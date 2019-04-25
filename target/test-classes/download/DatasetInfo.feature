Feature: Dataset info

  Background:
  * url 'https://download.pdok.io/kadaster/dkk/api/v1/'

  Scenario: DKK API geeft dataset info
    Given path 'dataset'
    When method GET
    Then status 200

  Scenario: DKK API geeft datum voor DKK GEO
    Given path 'dataset'
    When method GET
    Then status 200
#naamgeving DKKGeodatetimeTo voor var ?
    And match $ == {datetimeTo:"#notnull"}

#  Scenario: DKK API geeft datum voor DKK BGT
#     Given path 'dataset'
#    When method GET
#    Then status 200
#    And match $ == {DKKBGTdatetimeTo:"#notnull"}
