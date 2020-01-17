
@SMOKE

Feature: DKK WMS geeft getfeature info

  Scenario: DKK WMS geeft featureinfo voor perceel binnenhof

    Given url 'http://geodata.nationaalgeoregister.nl/kadastralekaart/wms/v4_0'
    And param VERSION = '1.3.0'
    And param service = 'WMS'
    And param request = 'GetFeatureInfo'
    And param bbox = '81312.54600256347,455097.63599487307,81354.96600256348,455140.0559948731'
    And param layers = 'perceel'
    And param QUERY_LAYERS = 'perceel'
    And param i = 50
    And param j = 50
    And param WIDTH = 101
    And param HEIGHT = 101
    And param CRS = 'EPSG:28992'
    And param INFO_FORMAT = 'application/json'

    When method GET
    Then status 200
   # And match response == read('./expectedOutcome/perceelbinnenhof.json')
     * eval karate.embed(responseBytes,'application/json')

  Scenario Outline: check all layer <v4layer>

    Given url 'http://geodata.nationaalgeoregister.nl/kadastralekaart/wms/v4_0'
    And param VERSION = '1.3.0'
    And param service = 'WMS'
    And param request = 'GetFeatureInfo'
    And param bbox = '81312.54600256347,455097.63599487307,81354.96600256348,455140.0559948731'
    And param layers = '<v4layer>'
    And param QUERY_LAYERS = '<v4layer>'
    And param i = 50
    And param j = 50
    And param WIDTH = 101
    And param HEIGHT = 101
    And param CRS = 'EPSG:28992'
    And param INFO_FORMAT = 'application/json'

    When method GET
    Then status 200

      * eval karate.embed(responseBytes,'application/json')

    Examples:
      | v4layer             | 
      | Perceel               |
      | kadastraleGrens       |
      | Bebouwing             |
      | OpenbareRuimteNaam    |
   
