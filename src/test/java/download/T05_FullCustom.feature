@SMOKE
Feature: DKK Api geeft Custom full

  Background:
    * url apiBaseUrl +'kadastralekaart/api/v4_0/full/custom'


  Scenario Outline: download full custom op locatie <locatie> voor feature(s): <dkkfeaturetype>

    Given request {format: 'gml',featuretypes: ["<dkkfeaturetype>"],  geofilter: '<poly>' }
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
      | testname                             | dkkfeaturetype                                             | locatie         | poly                                                                                                                                                                                               |
      | 1_perceel                            | perceel                                                    | hofvijver       | POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))                                   |
      | 2_kadastralegrens                    | kadastralegrens                                            | hofvijver       | POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))                                   |
      | 3_pand                               | pand                                                       | hofvijver       | POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))                                   |
      | 4_openbareruimtelabel                | openbareruimtelabel                                        | hofvijver       | POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))                                   |
      | 5_4features_hof                      | perceel",  "kadastralegrens", "pand", "openbareruimtelabel | hofvijver       | POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))                                   |
      | 6_perceelenOpenbareruimtelabel_swift | perceel","openbareruimtelabel                              | swifterband     | POLYGON((171808.896 509246.97597949224,172768.51212304688 509276.54393847665,172760.44804101562 508392.1920000001,171773.95212304688 508381.43995898444,171808.896 509246.97597949224))            |
      | 7_dkkbgt_brug                        | pand","openbareruimtelabel                                 | Apeldoorndebrug | POLYGON((194115.26404101565 465939.2639692384,194369.2799794922 465943.296010254,194351.80802050783 465775.29595898447,194093.76006152347 465724.2240205079,194115.26404101565 465939.2639692384)) |
