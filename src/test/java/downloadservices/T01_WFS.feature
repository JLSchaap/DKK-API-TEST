@SMOKE
Feature: DKK WFS

    Scenario: DKK WFSgeeft features voor binnenhof

        * configure readTimeout = 40000
        * def expectedOutcome = read('./expectedOutcome/hofvijverWGS84.json')
        Given url 'https://geodata.nationaalgeoregister.nl/kadastralekaartv3/wfs?service=WFS&'

        * def box1 = '81305.27206213083,455190.78582254506,81343.90228717012,455225.4270569553'
        And param request = 'GetFeature'
        And param bbox = box1
        And param typeName = 'perceel'
        And param outputFormat = 'application/json'
        And param srsName = 'EPSG:4326'
        When method GET
        Then status 200

        And match response == expectedOutcome
        * eval karate.embed(responseBytes,'application/json')

    Scenario Outline: Scenario Outline name: DKK WFSgeeft features hits voor layer <no>
        * def cap = read('./expectedOutcome/wfscapabilities.xml')
        * def layer = karate.xmlPath(cap,'/WFS_Capabilities/FeatureTypeList/FeatureType[<no>]/Name')

        Given url 'https://geodata.nationaalgeoregister.nl/kadastralekaartv3/wfs?service=WFS&'
        And param SERVICE = 'WFS'
        And param REQUEST = 'GetFeature'
        And param VERSION = '2.0.0'
        And param TYPENAMES = layer
        And param RESULTTYPE = 'hits'

        When method GET
        Then status 200


        * def featcount = karate.xmlPath(response, '/FeatureCollection/@numberMatched')
        * print layer, ' count ', featcount
        Examples:
            | no |
            | 1  |
            | 2  |
            | 3  |
            | 4  |

