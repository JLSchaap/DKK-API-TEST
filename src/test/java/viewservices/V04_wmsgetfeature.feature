
@WIP

Feature: DKK WMS geeft getfeature info

  Scenario: DKK WMS geeft featureinfo voor perceel binnenhof

    Given url 'https://geodata.nationaalgeoregister.nl/kadastralekaartv3/wms?'
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
    And match response == read('./expectedOutcome/perceelbinnenhof.json')

  Scenario Outline: check all layer

    Given url 'https://geodata.nationaalgeoregister.nl/kadastralekaartv3/wms?'
    And param VERSION = '1.3.0'
    And param service = 'WMS'
    And param request = 'GetFeatureInfo'
    And param bbox = '81312.54600256347,455097.63599487307,81354.96600256348,455140.0559948731'
    And param layers = '<v3layer>'
    And param QUERY_LAYERS = '<v3layer>'
    And param i = 50
    And param j = 50
    And param WIDTH = 101
    And param HEIGHT = 101
    And param CRS = 'EPSG:28992'
    And param INFO_FORMAT = 'application/json'

    When method GET
    Then status 200

    Examples:
      | v3layer         |
      | bebouwing       |
      | annotatie       |
      | perceel         |
      | kadastralegrens |

