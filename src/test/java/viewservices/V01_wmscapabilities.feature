
@WIPx
Feature: DKK WMS geeft capabilities



  Scenario: DKK WMS geeft capabilities

    Given url  apiBaseUrl  + '/kadastralekaartv4/'
    And param VERSION = '1.3.0'
    And param request = 'GetCapabilities'
    And param service = 'WMS'

    When method GET
    Then status 200
    And match response == read('./expectedOutcome/wmscap.xml')
    
  
