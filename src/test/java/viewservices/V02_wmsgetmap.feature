@SMOKE
Feature: DKK WMS geeft map V3

  Scenario: DKK WMS geeft map voor perceel binnenhof

    Given url 'https://geodata.nationaalgeoregister.nl/kadastralekaartv3/wms?'
    And param VERSION = '1.3.0'
    And param service = 'WMS'
    And param request = 'GetMap'
    And param bbox = '81209.29166651209,455070.83633325604,81550.075000193,455210.9596667323'
    And param layers = 'perceel'
    And param WIDTH = 400
    And param HEIGHT = 400
    And param CRS = 'EPSG:28992'
    And param format = 'image/png'

    When method GET
    Then status 200
    And match header Content-Disposition contains 'inline'
    And match header Content-Disposition contains ' filename=kadastralekaartv3-perceel.png'
    And match header Content-Type == 'image/png'
    * eval karate.embed(responseBytes,'image/png')



