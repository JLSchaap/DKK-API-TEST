@SMOKE
Feature: DKK WFS

    Background:
        * url 'http://geodata.nationaalgeoregister.nl/kadastralekaart/wfs/v4_0'
        * configure readTimeout = 120000

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

    Scenario Outline: Scenario Outline name: DKK WFSgeeft features hits (count) en a feature for layer <no>
        * def cap = read('./expectedOutcome/wfscapabilitiesv4new.xml')
        * def layer = karate.xmlPath(cap,'/WFS_Capabilities/FeatureTypeList/FeatureType[<no>]/Name')

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
            | 6  |
            | 7  |

