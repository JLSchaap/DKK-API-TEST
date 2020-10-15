@SMOKE
Feature: geeft capabilities



  Scenario: CSW geeft capabilities

  Given url  'http://nationaalgeoregister.nl/geonetwork/srv/dut/csw'
    And param request = 'GetCapabilities'
    And param service = 'CSW'
 
   When method GET
   Then status 200
    And match karate.xmlPath(response, '/Capabilities/ServiceIdentification/ServiceTypeVersion') == '2.0.2' 
    And match karate.xmlPath(response, '/Capabilities/ServiceIdentification/Title') == "CSW Nationaal Georegister (NGR)"
