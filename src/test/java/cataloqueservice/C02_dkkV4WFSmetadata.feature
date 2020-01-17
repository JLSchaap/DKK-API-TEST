@SMOKE
Feature: check dkk record

ff9315c8-f25a-4d01-9245-5cf058314ebf

  Scenario: CSW geeft DKK records 

  Given url  'http://nationaalgeoregister.nl/geonetwork/srv/dut/csw'
    And param request = 'GetRecordById'
    And param version = '2.0.2'
    And param elementSetName = 'full'
    And param service = 'CSW'
    And param OutputSchema = 'http://www.opengis.net/cat/csw/2.0.2'
    And param id = 'ff9315c8-f25a-4d01-9245-5cf058314ebf'
  #  And param id = 'a29917b9-3426-4041-a11b-69bcb2256904'
 
   When method GET
   Then status 200
   And match karate.xmlPath(response, '/GetRecordByIdResponse/Record/title') == 'Kadastrale Kaart v4 WFS' 
  