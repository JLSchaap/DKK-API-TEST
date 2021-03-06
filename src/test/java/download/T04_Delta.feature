@SMOKE
Feature: DKK API geeft info over beschikbare delta dataset leveringen
  Door middel van "since" kun je opvragen of er nog nieuwe delta's zijn. Zet hiervoor het deltaID in link van de delta. Dit geeft uiteindelijk een lijst met nog te downloaden delta's. Deltaleveringen worden tot en met 31 dagen terug bewaard.

  Background:
  * url apiBaseUrl +'kadastralekaart/api/v4_0/'

  Scenario: DKK API geeft delta info
    Given path 'delta'
    When method GET
    Then status 200
    And match response contains { deltas: '#present' }

  Scenario: DKK API geeft delta minimaal een UUID delta
    Given path 'delta'
    When method GET
    Then status 200
    And match response.deltas[0].id == "#uuid"
