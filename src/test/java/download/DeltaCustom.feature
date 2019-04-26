
Feature: DKK Api geeft Custom delta initial request

  Background:
  * url 'https://download.pdok.io/kadaster/dkk/api/v1/delta/custom'

  Scenario: downoad delta initial locatie buitenhof
    Given request {format: 'gml',featuretypes: ["perceel"],  geofilter: 'POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))' }
    When method post

    Then status 202
    And match response == { downloadRequestId: '#uuid' , _links:'#notnull'}
    And def downloadRequestId = response.downloadRequestId
    And def statusurl = url + '/' + downloadRequestId
    * print 'statusurl:', statusurl
    Given url statusurl
    When method GET
    And retry until responseStatus == 200