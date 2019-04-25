
Feature: DKK Api geeft Custom full

  Background:
    * url 'https://download.pdok.io/kadaster/dkk/api/v1/full/custom'

  Scenario: download full custom op locatie buitenhof request
    Given request {format: 'gml',featuretypes: ["perceel"],  geofilter: 'POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))' }
    When method post

    Then status 202
    And match response == { downloadRequestId: '#uuid' , _links:'#notnull' }

    And def links = response._links
    And def downloadRequestId = response.downloadRequestId
    And def status = response.status

    * print 'links:' , _links

    * print 'extracId:', downloadRequestId

   Scenario: download full custom op locatie buitenhof get status
     * def statusurl = 'https://download.pdok.io//kadaster/dkk/api/v1/full/custom/' +downloadRequestId





     Given url statusurl
     When method GET
     Then status 200
    # And match response == { downloadRequestId: '#uuid' }
    #And retry until responseStatus == 200
    #When method get
