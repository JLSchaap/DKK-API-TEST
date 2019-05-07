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


  #blop i.p.v. redirect. PDOK-9006

  Scenario: DKK Api geeft delta full

    * print "bepaal een delta id "
    Given url 'https://download.pdok.io/kadaster/dkk/api/v1/delta'
    When method GET
    Then status 200
    And match response.deltas[7].id == "#uuid"
    # And match response.deltas[0].timeWindow.from == "#notnull"
    And match response.deltas[7].timeWindow.to == "#notnull"
    And def arraylenght = response.deltas.length
    And def deltauuid = response.deltas[7].id
    * print "lenght:" , arraylenght
    # * print "from:", response.deltas[1].timeWindow.from
    * print "to", response.deltas[7].timeWindow.to
    * print "ophalen voor delta:", deltauuid


    Given url 'https://download.pdok.io/kadaster/dkk/api/v1/delta/predefined/dkk-gml-nl.zip'      
    And param delta-id = deltauuid
    When method GET
    Then status 307

    * def location = 'https://download.pdok.io/' + responseHeaders['Location'][0]

    Given url location

    When method HEAD
    Then status 200
    And match responseHeaders['Content-Length'][0] == '#notnull'
    And match responseHeaders['Content-Type'][0] == 'application/zip'
    And def zipsize =  responseHeaders['Content-Length'][0]
    * print "location", location
    * print "size", zipsize
    
