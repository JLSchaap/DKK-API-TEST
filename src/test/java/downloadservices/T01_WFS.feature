@SMOKE

Feature: DKK WFS

    Scenario: DKK WFSgeeft features voor binnenhof
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