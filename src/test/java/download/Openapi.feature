@PDOKNL @PDOKIO
Feature: DKK API heeft open api configuratie
  de API wordt beschikbaargesteld d.m.v. een openapi spec
  Background:
  * url apiBaseUrl +'kadaster/dkk/api/v1/'

  Scenario: DKK API geeft open api spec
    Given path 'openapi.json'
    When method GET
    Then status 200
   And match response contains  read('./expectedOutcome/openapi.json')

