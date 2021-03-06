@ExtraSmoke
Feature: DKK Api geeft Custom delta mutatierequest voor 3e delta
  Dit feature test de mutatie download voor een specifiek intressegebied voor de 3e delta. 

  Background:
    * url apiBaseUrl +'kadastralekaart/api/v4_0/delta/custom'


  Scenario: download delta mutatie delta locatie buitenhof voor 3e hardcoded delta

    * print "bepaal een delta id "
    Given url apiBaseUrl +'kadastralekaart/api/v4_0/delta'
    When method GET
    Then status 200
    And match response.deltas[3]id == "#uuid"
    And match response.deltas[3].timeWindow.from == "#notnull"
    And match response.deltas[3].timeWindow.to == "#notnull"
    And def arraylenght = response.deltas.length
    And def deltauuid = response.deltas[3].id
    * print "lenght:" , arraylenght
    * print "from:", response.deltas[3].timeWindow.from
    * print "to", response.deltas[3].timeWindow.to



    * print "haal data op voor delta:" , deltauuid
    * url apiBaseUrl +'kadastralekaart/api/v4_0/delta/custom'
    Given request {deltaId: '#(deltauuid)' , format: 'gml',featuretypes: ["perceel"],  geofilter: 'POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))' }
    When method post

    Then status 202
    And match response == { downloadRequestId: '#uuid' , _links:'#notnull'}
    And def downloadRequestId = response.downloadRequestId
    And def links = response._links
    * print "update delta status links:" links
    And def statusurl = apiBaseUrl  + links.status.href

    * print 'statusurl', statusurl
 


    Given url statusurl
    When method GET
    * print "waiting update delta link"
    And retry until responseStatus == 201

    Given url statusurl
    When method GET
    And def downloadlink = response._links
    And  match response == { _links:'#notnull' , progress:100, status:'COMPLETED' }
    * print "downloadlink:", downloadlink