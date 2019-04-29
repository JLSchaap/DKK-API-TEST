Feature: DKK Api geeft predefined Fulls voor geheel Nederland (delta en gml)

  Background:
  * url 'https://download.pdok.io/'
  * configure followRedirects = false

  Scenario Outline: DKK Api geeft <omschrijving> (url: <urlpath>)

    Given path <urlpath>
    When method GET
    Then status 307

    * def location = responseHeaders['Location'][0]

    Given path location
    When method HEAD
    Then status 200
    And match responseHeaders['Content-Length'][0] == '#notnull'
    And match responseHeaders['Content-Type'][0] == 'application/zip'
    And def zipsize =  responseHeaders['Content-Length'][0]
    * print "location", location
    * print "size", zipsize
    Examples:
      | omschrijving                  | urlpath                                                      |
      | Heel Nederland gml            | 'kadaster/dkk/api/v1//full/predefined/dkk-gml-nl-nohist.zip' |
      | Heel Nederland initiele delta | 'kadaster/dkk/api/v1/delta/predefined/dkk-gml-nl.zip'        |



