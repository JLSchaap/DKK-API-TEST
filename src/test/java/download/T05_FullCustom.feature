@SMOKE
Feature: DKK Api geeft Custom full

  Background:
    * url apiBaseUrl +'kadaster/dkk/api/v1/full/custom'


  Scenario Outline: download full custom op locatie buitenhof voor feature(s): <dkkfeaturetype>

    Given request {format: 'gml',featuretypes: ["<dkkfeaturetype>"],  geofilter: 'POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))' }
    When method post

    Then status 202
    And match response == { downloadRequestId: '#uuid' , _links:'#notnull' }

    And def links = response._links
    And def downloadRequestId = response.downloadRequestId
    And def status = response.status
    And def statusurl = apiBaseUrl  + links.status.href

    * print 'links:' , links
    * print  'statusurl', statusurl

    * print 'extracId:', downloadRequestId

    * configure retry = { count: 20, interval: 5000 }


    Given url statusurl
    When method GET
    * print "waiting update delta link"
    And retry until responseStatus == 201

    Given url statusurl
    When method GET
    And def downloadlink = apiBaseUrl  +  response._links.download.href
    And  match response == { _links:'#notnull' , progress:100, status:'COMPLETED' }

    * print "downloadlink:", downloadlink
    Given url downloadlink
    When method HEAD
    Then status 200
    And match responseHeaders['Content-Length'][0] == '#notnull'
    And match responseHeaders['Content-Type'][0] == 'application/zip'
    And def zipsize =  responseHeaders['Content-Length'][0]
   
    * print "size", zipsize
    * assert zipsize > 300

    * def mydownloads = Java.type('download.DataStorage')
    * def LocalDateTime = Java.type('java.time.LocalDateTime')
    * def db = new mydownloads
    * eval db.mywriteln('- Test: T05_<testname>\n'+'  Url: '+downloadlink+'\n  Size: '+zipsize+'\n  Time: '+ LocalDateTime.now() +'\n' , 'target/surefire-reports/fullcustomurl.yaml')


    Examples:
      | testname                       | dkkfeaturetype                                         |
      | 1_perceel                      | perceel                                                |
      | 2_kadastralegrens              | kadastralegrens                                        |
      | 3_pand                         | pand                                                   |
      | 4_openbareruimtelabel          | openbareruimtelabel                                    |
      | 5_perceelenOpenbareruimtelabel | perceel","openbareruimtelabel                          |
      | 6_AlleDkkFeatures              | perceel","kadastralegrens","openbareruimtelabel","pand |
