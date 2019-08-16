@SMOKE
Feature: DKK WMS geeft map  V4
  Background:
    * url 'http://geodata.nationaalgeoregister.nl/kadastralekaart/wms/v4_0'
    * configure readTimeout = 120000

  Scenario Outline: WMS geef voor <toepassing> laag met legenda <legenda tekst> <type> <bbox> <width> <height>

    * def box1_NL = "-25000,250000,280000,860000"
    * def box2_BH = "81000,455900,81600,456500"
    * def box2_BH2 = "81000,455900,89320,461750"

    Given path ""
    And param VERSION = '1.3.0'
    And param service = 'WMS'
    And param request = 'GetMap'
    And param bbox = <bbox>
    And param layers = '<v4layer>'
    And param WIDTH = <width>
    And param HEIGHT = <height>
    And param CRS = 'EPSG:28992'
    And param format = 'image/png'

    When method GET
    Then status 200
    # And match header Content-Disposition contains 'inline'
    # And match header Content-Disposition contains ' filename=kadastralekaartv4-<v4layer>.png'
    And match header Content-Type == 'image/png'
    And def filesize =  responseHeaders['Content-Length'][0]
    # And def pars = params

    * print "v4 image type: <type>"
    * eval karate.embed(responseBytes,'image/png')

    * def mydownloads = Java.type('download.DataStorage')
    * def LocalDateTime = Java.type('java.time.LocalDateTime')
    * def db = new mydownloads
    * eval db.mywriteln('- Test: V02_WMS test <test> <width> <height> type <type> ' + '\n'+'  responseTime: ' + responseTime + '\n  Size: ' + filesize + '\n  Time: '+ LocalDateTime.now() + '\n' , 'target/surefire-reports/wmsv40.yaml')


    Given path ""
    And param VERSION = '1.3.0'
    And param service = 'WMS'
    And param request = 'GetLegendGraphic'
    And param layer = '<v4layer>'
    And param WIDTH = 40
    And param HEIGHT = 40
    And param CRS = 'EPSG:28992'
    And param format = 'image/png'
    And param SLD_VERSION = '1.1.0'

    When method GET
    Then status 200
    #And match header Content-Disposition contains ' filename=geoserver-GetLegendGraphic.image'
    #And match header Content-Type == 'image/png'
    * print "v4 legenda image type <type>"
    * eval karate.embed(responseBytes,'image/png')

    * def mydownloads = Java.type('download.DataStorage')
    * def LocalDateTime = Java.type('java.time.LocalDateTime')
    * def db = new mydownloads
    * eval db.mywriteln('- Test: V02_WMS legenda test <test> type <type> ' + '\n'+'  responseTime: ' + responseTime + '\n  Size: ' + filesize + '\n  Time: '+ LocalDateTime.now() + '\n' , 'target/surefire-reports/wmsv40.yaml')


    Given path ""
    And param VERSION = '1.3.0'
    And param service = 'WMS'
    And param request = 'GetMap'
    And param bbox = <bbox>
    And param layers = '<v4layer>'
    And param styles = '<v4style>'
    And param WIDTH = <width>
    And param HEIGHT = <height>
    And param CRS = 'EPSG:28992'
    And param format = 'image/png'

    When method GET
    Then status 200
    # And match header Content-Disposition contains 'inline'
    # And match header Content-Disposition contains ' filename=kadastralekaartv4-<v4layer>.png'
    And match header Content-Type == 'image/png'
    And def filesize =  responseHeaders['Content-Length'][0]
    # And def pars = params

    * print "v4 image type: <type>"
    * eval karate.embed(responseBytes,'image/png')

    * def mydownloads = Java.type('download.DataStorage')
    * def LocalDateTime = Java.type('java.time.LocalDateTime')
    * def db = new mydownloads
    * eval db.mywriteln('- Test: V02_WMS test <test> style <v4style> <width> <height> type <type> ' + '\n'+'  responseTime: ' + responseTime + '\n  Size: ' + filesize + '\n  Time: '+ LocalDateTime.now() + '\n' , 'target/surefire-reports/wmsv40.yaml')




    Examples:
      | test | bbox     | width | height | v4layer               | v4style                                 | toepassing | LaagnaamV4         | symbool                        | legenda tekst         | MinScale | MaxScale | kleur           | type                                              |
      | 1    | box1_NL  | 600   | 600    | Bebouwing             | default                                 | scherm     | Bebouwing          | Bebouwing kadstrale kaart      | Bebouwing             | 100      | 5001     | rood            | pand contour                                      |
      | 1b   | box2_BH  | 600   | 600    | bebouwing             | default                                 | scherm     | Bebouwing          | Bebouwing kadstrale kaart      | Bebouwing             | 100      | 5001     | rood            | pand contour                                      |
      | 2    | box2_BH2 | 8320  | 5850   | bebouwing             | kadastralekaartv4:bebouwing_print       | print A0   | Bebouwing          | Bebouwing kadstrale kaart      | Bebouwing             | 50       | 2550     | rood            | pand contour                                      |
      | 2b   | box2_BH  | 600   | 600    | bebouwing             | default                                 | print      | Bebouwing          | Bebouwing kadstrale kaart      | Bebouwing             | 50       | 2550     | rood            | pand contour                                      |
      | 3    | box2_BH  | 600   | 600    | Nummeraanduidingreeks | default                                 | scherm     | Bebouwing          | Nummeraanduidingreeks          | Huisnummer            | 100      | 5001     | rood            | huisnummer (reeks) tekst 8                        |
      | 4    | box2_BH  | 4000  | 4000   | Nummeraanduidingreeks | kadastralekaartv4:bebouwing_print       | print      | Bebouwing          | Nummeraanduidingreeks          | Huisnummer            | 50       | 2550     | rood            | huisnummer (reeks) tekst 14                       |
      | 5    | box2_BH  | 600   | 600    | Nummeraanduidingreeks | default                                 | scherm     | OpenbareRuimteNaam | ORLweg                         | Straatnaam            | 100      | 2001     | tekst           | zwart tekst 10  (openbareRuimteType=Weg recht     |
      | 6    | box2_BH  | 4000  | 4000   | Nummeraanduidingreeks | kadastralekaartv4:bebouwing_print       | print      | OpenbareRuimteNaam | ORLweg                         | Straatnaam            | 50       | 1050     | tekst           | zwart tekst 20  (openbareRuimteType=Weg recht     |
      | 7    | box2_BH  | 600   | 600    | Nummeraanduidingreeks | default                                 | scherm     | OpenbareRuimteNaam | ORLwater                       | Waternaam             | 100      | 2001     | tekst           | zwart tekst 10  (openbareRuimteType=Water italic) |
      | 8    | box2_BH  | 4000  | 4000   | Nummeraanduidingreeks | kadastralekaartv4:bebouwing_print       | print      | OpenbareRuimteNaam | ORLwater                       | Waternaam             | 50       | 1050     | tekst           | zwart tekst 20  (openbareRuimteType=Water italic) |
      | 9    | box2_BH  | 600   | 600    | perceel               | default                                 | scherm     | Perceel            | Perceel Vlak                   | Perceel               | 100      | 5050     | zwart           | perceel contour stroke 1                          |
      | 10   | box2_BH  | 4000  | 4000   | perceel               | kadastralekaartv4:perceel_print         | print      | Perceel            | Perceel Vlak                   | Perceel               | 50       | 2550     | zwart           | perceel contour stroke1                           |
      | 11   | box2_BH  | 600   | 600    | perceel               | default                                 | scherm     | Perceel            | Perceel Bijpijling             | Bijpijling            | 100      | 5050     | zwart           | lijn stroke .5                                    |
      | 12   | box2_BH  | 4000  | 4000   | perceel               | kadastralekaartv4:perceel_print         | print      | Perceel            | Perceel Bijpijling             | Bijpijling            | 50       | 2550     | zwart           | lijn stroke .5                                    |
      | 13   | box2_BH  | 600   | 600    | perceel               | default                                 | scherm     | Perceel            | Perceelnummers Groot           | Perceelnummer         | 0        | 500      | tekst           | zwart arial italic 16                             |
      | 14   | box2_BH  | 600   | 600    | perceel               | default                                 | scherm     | Perceel            | Perceelnummers Normaal         | Perceelnummer         | 501      | 5050     | tekst           | zwart arial italic 8                              |
      | 15   | box2_BH  | 4000  | 4000   | perceel               | kadastralekaartv4:perceel_print         | print      | Perceel            | Perceelnummers Normaal Afdruk  | Perceelnummer         | 50       | 2550     | tekst           | zwart arial italic 20                             |
      | 16   | box2_BH  | 600   | 600    | kadastralegrens       | default                                 | scherm     | KadastraleGrens    | KadastraleGrens Definitief     | Definitieve grens     | 100      | 5050     | zwart           | lijn stroke 2                                     |
      | 17   | box2_BH  | 600   | 600    | kadastralegrens       | default                                 | scherm     | KadastraleGrens    | KadastraleGrens Voorlopig      | Voorlopige grens      | 100      | 5050     | geelbruinig     | lijn stroke 2                                     |
      | 18   | box2_BH  | 600   | 600    | kadastralegrens       | default                                 | scherm     | KadastraleGrens    | KadastraleGrens Administratief | Administratieve grens | 100      | 5050     | lichtblauw aqua | lijn stroke 2                                     |
      | 19   | box2_BH  | 4000  | 4000   | kadastralegrens       | kadastralekaartv4:kadastralegrens_print | print      | KadastraleGrens    | KadastraleGrens Definitief     | Definitieve grens     | 50       | 2550     | zwart           | lijn stroke 2                                     |
      | 20   | box2_BH  | 4000  | 4000   | kadastralegrens       | kadastralekaartv4:kadastralegrens_print | print      | KadastraleGrens    | KadastraleGrens Voorlopig      | Voorlopige grens      | 50       | 2550     | geelbruinig     | lijn stroke 2                                     |
      | 21   | box2_BH  | 4000  | 4000   | kadastralegrens       | kadastralekaartv4:kadastralegrens_print | print      | KadastraleGrens    | KadastraleGrens Administratief | Administratieve grens | 50       | 2550     | lichtblauw aqua | lijn stroke 2                                     |
