@SMOKE
Feature: DKK WFS

    Background:
        * url 'http://geodata.nationaalgeoregister.nl/kadastralekaart/wfs/v4_0'
        * configure readTimeout = 240000

    Scenario Outline: Scenario Outline name: DKK WFS geeft capabilities <version>

        Given path ''
        And param VERSION = '<version>'
        And param request = 'GetCapabilities'
        And param service = 'WFS'

        When method GET
        Then status 200
        * eval karate.embed(responseBytes,'application/xml')

        Examples:
            | version |
            | 2.2.0   |
            | 1.1.0   |
            | 1.0.0   |


    # And match response == read('./expectedOutcome/wfscapabilitiesv4new.xml')


    Scenario: DKK WFS geeft ListStoredQueries

        Given path ''
        And param VERSION = '2.0.0'
        And param request = 'ListStoredQueries'
        And param service = 'WFS'
        When method GET
        Then status 200
        * eval karate.embed(responseBytes,'application/xml')


    Scenario: DKK WFSgeeft features voor binnenhof

        * configure readTimeout = 40000
        * def expectedOutcome = read('./expectedOutcome/hofvijverWGS84.json')
        Given path ''

        * def box1 = '81305.27206213083,455190.78582254506,81343.90228717012,455225.4270569553'
        And param SERVICE = 'WFS'
        And param VERSION = '2.0.0'
        And param request = 'GetFeature'
        And param bbox = box1
        And param typeName = 'perceel'
        And param outputFormat = 'application/json'
        And param srsName = 'EPSG:4326'
        When method GET
        Then status 200

        #  And match response == expectedOutcome
        * eval karate.embed(responseBytes,'application/json')

 
    Scenario Outline:  DKK WFS geeft features voor binnenhof  <SRSCODE> <SRSNAME> <OUTPUTFORMAT>

        * configure readTimeout = 40000
        * def expectedOutcome = read('./expectedOutcome/hofvijverWGS84.json')
        Given path ''

        #* def box1 = '81305.27206213083,455190.78582254506,81343.90228717012,455225.4270569553'
        And param SERVICE = 'WFS'
        And param VERSION = '2.0.0'
        And param request = 'GetFeature'
        And param bbox = '<BOX>'
        And param typeName = 'perceel'
        And param outputFormat = '<OUTPUTFORMAT>'
        And param srsName = '<SRSCODE>'
        When method GET
        Then status 200

        #  And match response == expectedOutcome
        * eval karate.embed(responseBytes,'<OUTPUTFORMAT>')

        Examples:
            | BOX                                                                      | SRSCODE    | SRSNAME                                         | OUTPUTFORMAT                |
            #| | EPSG:28992 | Amersfoort / RD New -- Netherlands - Holland - Dutch                                           |
            #| | EPSG:25831 | ETRS89 / UTM zone 31N                                                                          |
            #| | EPSG:25832 | ETRS89 / UTM zone 32N                                                                          |
            #| | EPSG:3034  | ETRS89-extended / LCC Europe                                                                   |
            #| | EPSG:3035  | ETRS89-extended / LAEA Europe                                                                  |
            #| EPSG:3038  | EPSG:3038 DEPRECATED ETRS89 / TM26                                                             |
            #|  | EPSG:5709  | NAP height                                                                                     |
            #|  | EPSG:3857  | WGS 84 / Pseudo-Mercator -- Spherical Mercator, Google Maps, OpenStreetMap, Bing, ArcGIS, ESRI |  |
            #|  | EPSG:4258  | ETRS89                                                                                         |
            | 52.08040, 4.31267   , 52.08008, 4.31212                                  | EPSG:4326  | WGS84 - World Geodetic System 1984, used in GPS | application/json            |
            | 52.08040, 4.31267  ,    52.08008, 4.31212                                | EPSG:4326  | WGS84 - World Geodetic System 1984, used in GPS | text/xml; subtype=gml/3.2.1 |
            | 81305.27206213083,455190.78582254506,81343.90228717012,455225.4270569553 | EPSG:28992 | Amersfoort / RD New                             | application/json            |
            | 81305.27206213083,455190.78582254506,81343.90228717012,455225.4270569553 | EPSG:28992 | Amersfoort / RD New                             | text/xml; subtype=gml/3.2.1 |


    Scenario: DKK WFSgeeft specifiek feature (featureid)
        * configure readTimeout = 40000

        Given path ''
        And param SERVICE = 'WFS'
        And param VERSION = '2.0.0'
        And param request = 'GetFeature'
        And param outputFormat = 'application/json'
        And param srsName = 'EPSG:4326'
        And param featureid = "Perceel.ee5e1426-60ef-45cf-9f37-219e56cd9015"
        When method GET
        Then status 200
        #  And match response == expectedOutcome
        * eval karate.embed(responseBytes,'application/json')

    Scenario: DKK WFSgeeft specifiek feature (urn:ogc:def:query:OGC-WFS::GetFeatureById)
        * configure readTimeout = 40000

        Given path ''
        And param SERVICE = 'WFS'
        And param VERSION = '2.0.0'
        And param request = 'GetFeature'
        And param outputFormat = 'application/json'
        And param srsName = 'EPSG:4326'
        And param STOREDQUERY_ID = "urn:ogc:def:query:OGC-WFS::GetFeatureById"
        And param id = "perceel.ee5e1426-60ef-45cf-9f37-219e56cd9015"
        When method GET
        Then status 200
        #  And match response == expectedOutcome
        * eval karate.embed(responseBytes,'application/json')

    @WIPTEST
    Scenario: DKK WFSgeeft specifiek feature (urn:ogc:def:query:OGC-WFS::GetFeatureById)
        * configure readTimeout = 40000

        Given path ''
        And param SERVICE = 'WFS'
        And param VERSION = '2.0.0'
        And param request = 'GetFeature'
        And param outputFormat = 'application/json'
        And param srsName = 'EPSG:4326'
        And param STOREDQUERY_ID = "urn:ogc:def:query:OGC-WFS::GetFeatureById"
        And param id = "ee5e1426-60ef-45cf-9f37-219e56cd9015"
        When method GET
        Then status 200

        #  And match response == expectedOutcome
        * eval karate.embed(responseBytes,'application/json')



    Scenario Outline: Scenario Outline name: DKK WFS geeft describe, features hits (count) en a feature for layer <no>
        * def cap = read('./expectedOutcome/wfscapabilitiesv4new.xml')
        * def layer = karate.xmlPath(cap,'/WFS_Capabilities/FeatureTypeList/FeatureType[<no>]/Name')

        Given  path ''
        And param SERVICE = 'WFS'
        And param REQUEST = 'DescribeFeatureType'
        And param VERSION = '2.0.0'
        And param TYPENAMES = layer


        When method GET
        Then status 200
        * json jsonVar = karate.xmlPath(response,'/schema/complexType/complexContent/extension/sequence')
        * print 'fields:' , jsonVar

        Given  path ''
        And param SERVICE = 'WFS'
        And param REQUEST = 'GetFeature'
        And param VERSION = '2.0.0'
        And param TYPENAMES = layer
        And param RESULTTYPE = 'hits'

        When method GET
        Then status 200
        And match karate.xmlPath(response, '/FeatureCollection/@numberReturned') == 0


        * def featcount = karate.xmlPath(response, '/FeatureCollection/@numberMatched')
        * print layer, ' count ', featcount

        * def mydownloads = Java.type('download.DataStorage')
        * def LocalDateTime = Java.type('java.time.LocalDateTime')
        * def db = new mydownloads
        * eval db.mywriteln('- Test: WFS count '+ '\n    Layer:'+ layer +'\n'+'    Count:' + featcount + '\n    Time:'+ LocalDateTime.now() + '\n' , 'target/surefire-reports/wfscount.yaml')


        Given  path ''
        And param SERVICE = 'WFS'
        And param REQUEST = 'GetFeature'
        And param VERSION = '2.0.0'
        And param TYPENAMES = layer
        And param COUNT = 1
        And param STARTINDEX = 0

        When method GET
        Then status 200
        And match karate.xmlPath(response, '/FeatureCollection/@numberReturned') == 1


        * def featcount = karate.xmlPath(response, '/FeatureCollection/@numberMatched')
        * print layer, ' count ', featcount

        * eval karate.embed(responseBytes,'application/json')
        Examples:
            | no |
            | 1  |
            | 2  |
            | 3  |
            | 4  |
            | 5  |


