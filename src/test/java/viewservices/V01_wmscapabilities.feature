
@SMOKE
Feature: DKK WMS geeft capabilities



  Scenario: DKK WMS geeft capabilities

    Given url  'http://geodata.nationaalgeoregister.nl/kadastralekaart/wms/v4_0'
    And param VERSION = '1.3.0'
    And param request = 'GetCapabilities'
    And param service = 'WMS'

    When method GET
    Then status 200
   # And match response == read('./expectedOutcome/wmscapv4_0.xml')
    
  
