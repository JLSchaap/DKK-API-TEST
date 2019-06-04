@Template
Feature: using __arg
  Dit feature test de download voor een specifiek interessegebied voor een specifieke delta

  Background:
    * url apiBaseUrl +'kadaster/dkk/api/v1/delta/custom'
   # * def requestparams = {format: "gml",featuretypes: ["perceel"],  geofilter: 'POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))' }
    * def requestparams = __arg
    * print requestparams

  Scenario: downoad delta initial locatie buitenhof

    Given request requestparams
    When method post

    Then status 202
    And match response == { downloadRequestId: '#uuid' , _links:'#notnull'}
    And def downloadRequestId = response.downloadRequestId
    And def links = response._links
    * print "initial delta status links:" links
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