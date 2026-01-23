
@WIPXL
Feature: DKK WMS geeft styles
  Background:
    * url 'http://geodata.nationaalgeoregister.nl/kadastralekaart/wms/v4_0'



  Scenario: DKK WMS geeft styles

    Given path ""
    And param VERSION = '1.3.0'
    And param request = 'GetStyles'
    And param service = 'WMS'

    When method GET
    Then status 200
# And match response == read('./expectedOutcome/wmscap.xml')

