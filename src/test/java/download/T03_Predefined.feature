@SMOKE
Feature: DKK Api geeft predefined Fulls voor geheel Nederland (delta en gml)

  Background:
    * configure followRedirects = false

    * print "bepaal een delta ids "
    Given url apiBaseUrl + 'kadastralekaart/api/v4_0/delta'
    And param count = 1000
    And param after-delta-id = "b2219778-e94c-40b0-92bd-95e3491af2bb"
    When method GET
    Then status 200
    And def alldelta = response.deltas
    * print "alldelta:", alldelta
    * def ids = karate.jsonPath (alldelta, '[*].id')
    * print "ids", ids


  Scenario Outline: DKK Api geeft <testnaam> (url: <urlpath>)

    Given url apiBaseUrl + <urlpath>
    When method GET
    Then status 307

    * def location = responseHeaders['Location'][0]

    Given url  apiBaseUrl + location
    When method HEAD
    Then status 200
    And match responseHeaders['Content-Length'][0] == '#notnull'
    And match responseHeaders['Content-Type'][0] == 'application/zip'
    And def zipsize =  responseHeaders['Content-Length'][0]
    * print "location", location
    * print "size", zipsize
    * assert zipsize > 3000000000

    * def mydownloads = Java.type('download.DataStorage')
    * def LocalDateTime = Java.type('java.time.LocalDateTime')
    * def db = new mydownloads
    * def downloadlink = apiBaseUrl + location
    * eval db.mywriteln('- Test: T03_<testnaam>\n'+'  Url: '+ downloadlink +'\n  Size: '+zipsize+'\n  Time: '+ LocalDateTime.now() +'\n' , 'target/surefire-reports/<testnaam>.yaml')



    Examples:
      | testnaam                         | urlpath                                                           |
      | T03HeelNederlandDkk              | 'kadastralekaart/api/v4_0//full/predefined/dkk-gml-nl-nohist.zip' |
      | T03HeelNederlandInitieleDeltaDkk | 'kadastralekaart/api/v4_0/delta/predefined/dkk-gml-nl.zip'        |





  Scenario Outline: downoad predefined deltas for <id>
    Given url  apiBaseUrl + 'kadastralekaart/api/v4_0/delta/predefined/dkk-gml-nl.zip'
    And param delta-id = '<id>'
    When method GET
  #  Then status 200
    And match responseHeaders['Content-Length'][0] == '#notnull'
    And match responseHeaders['Content-Type'][0] == 'application/zip'
    And def zipsize =  responseHeaders['Content-Length'][0]
    * print "size", zipsize


     * def location = responseHeaders['Location'][0]

    Given url  apiBaseUrl + location
    When method HEAD
    Then status 200
    And match responseHeaders['Content-Length'][0] == '#notnull'
    And match responseHeaders['Content-Type'][0] == 'application/zip'
    And def zipsize =  responseHeaders['Content-Length'][0]
    * print "location", location
    * print "size", zipsize
    * assert zipsize > 1000


    Examples:
      | karate.mapWithKey(ids, 'id') |