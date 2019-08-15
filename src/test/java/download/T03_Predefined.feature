@SMOKE
Feature: DKK Api geeft predefined Fulls voor geheel Nederland (delta en gml)

  Background:
    * url apiBaseUrl
    * configure followRedirects = false

  Scenario Outline: DKK Api geeft <testnaam> (url: <urlpath>)

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
    * assert zipsize > 3000000000

    * def mydownloads = Java.type('download.DataStorage')
    * def LocalDateTime = Java.type('java.time.LocalDateTime')
    * def db = new mydownloads
    * def downloadlink = apiBaseUrl + location
    * eval db.mywriteln('- Test: T03_<testnaam>\n'+'  Url: '+ downloadlink +'\n  Size: '+zipsize+'\n  Time: '+ LocalDateTime.now() +'\n' , 'target/surefire-reports/<testnaam>.yaml')



    Examples:
      | testnaam                         | urlpath                                                      |
      | T03HeelNederlandDkk              | 'kadastralekaart/api/v4_0//full/predefined/dkk-gml-nl-nohist.zip' |
      | T03HeelNederlandInitieleDeltaDkk | 'kadastralekaart/api/v4_0/delta/predefined/dkk-gml-nl.zip'        |


