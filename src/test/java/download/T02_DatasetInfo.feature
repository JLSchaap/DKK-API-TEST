@SMOKE
Feature: Dataset info

  Background:
    * url apiBaseUrl + 'kadastralekaart/api/v4_0/'
    * def datasetstruct =
    """
    {
    "timeliness": [
    {
      "featuretype": "perceel",
      "datetimeTo": "#string"
    },
    {
      "featuretype": "kadastralegrens",
      "datetimeTo": "#string"
    },
    {
      "featuretype": "pand",
      "datetimeTo": "#string"
    },
    {
      "featuretype": "openbareruimtelabel",
      "datetimeTo": "#string"
    }
  ]
}
"""

  Scenario: DKK API geeft dataset info
    Given path 'dataset'
    When method GET
    Then status 200
    And match response contains { timeliness: '#present' }
    And match response == datasetstruct
  




