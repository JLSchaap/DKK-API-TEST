@SMOKE
Feature: DKK WFS

    Background:
        * url 'http://geodata.nationaalgeoregister.nl/kadastralekaart/wfs/v4_0'
        * configure readTimeout = 240000
    
  

    Scenario: DKK WFS geeft capabilities

        Given path ''
        And param VERSION = '2.2.0'
        And param request = 'GetCapabilities'
        And param service = 'WFS'

        When method GET
        Then status 200
        And match response == read('./expectedOutcome/wfscapabilitiesv4new.xml')



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


