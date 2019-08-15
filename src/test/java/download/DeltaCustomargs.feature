@Template
Feature: using __arg
  Dit feature test de download voor een specifiek interessegebied voor een specifieke delta

  Background:
    * url apiBaseUrl +'kadastralekaart/api/v4_0/delta/custom'
    # * def requestparams = {format: "gml",featuretypes: ["perceel"],  geofilter: 'POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))' }
    * def requestparams = __arg
    * print requestparams

  Scenario: downoad delta locatie buitenhof

    Given request requestparams
    When method post

    Then status 202
    And match response == { downloadRequestId: '#uuid' , _links:'#notnull'}
    And def downloadRequestId = response.downloadRequestId
    And def links = response._links
    * print "delta status links:" links
    And def statusurl = apiBaseUrl + links.status.href

    * print 'statusurl', statusurl
    Given url statusurl
    When method GET
    And retry until responseStatus == 201

    Given url statusurl
    When method GET
    And def downloadlink = response._links
    And  match response == { _links:'#notnull' , progress:100, status:'COMPLETED' }
    * print "downloadlink:", downloadlink

    Given url apiBaseUrl + downloadlink.download.href
    When method HEAD
    Then status 200
    And match responseHeaders['Content-Length'][0] == '#notnull'
    And match responseHeaders['Content-Type'][0] == 'application/zip'
    And def zipsize =  responseHeaders['Content-Length'][0]
    * print "###"
    * print "location", apiBaseUrl + downloadlink.download.href
    * print "size", zipsize
    * assert zipsize > 600

    * def mydownloads = Java.type('download.DataStorage')
    * def LocalDateTime = Java.type('java.time.LocalDateTime')
    * def db = new mydownloads
    * eval db.mywriteln('- Test: DeltaUpdate_'+ __loop +' '+ '\n    leveringsId:'+ downloadRequestId +'\n'+'    Url:'+apiBaseUrl + downloadlink.download.href+'\n    Size:'+zipsize+'\n    Time:'+ LocalDateTime.now() +'\n' , 'target/surefire-reports/delta_url.yaml')
