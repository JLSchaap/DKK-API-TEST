@DISABLEtetraag
Feature: DKK WFS FES Filter

  Background:
    * url 'http://geodata.nationaalgeoregister.nl/kadastralekaart/wfs/v4_0'
    * configure readTimeout = 120000

 # Scenario Outline: DKK WFS heeft <capabilities> capabilities

 #   * def cap = read('./expectedOutcome/wfscapabilitiesv4new.xml')
 #   * match "TRUE" ==  karate.xmlPath(cap,'/WFS_Capabilities/<capabilities>/Conformance/Constraint[1]/DefaultValue')

  #  Examples:
  #    | capabilities        |
  #    | Filter_Capabilities |

  Scenario Outline:  WFS filter propertie <feature> <prop> =  <value> gives <resulttype>
    * def xmlfilter =
      """
      <fes:Filter xmlns:fes="http://www.opengis.net/fes/2.0">
      <fes:PropertyIsEqualTo>
      <fes:ValueReference><prop></fes:ValueReference>
      <fes:Literal><value></fes:Literal>
      </fes:PropertyIsEqualTo>
      </fes:Filter>
      """

    Given  path ''
    And param SERVICE = 'WFS'
    And param REQUEST = 'GetFeature'
    And param resulttype = '<resulttype>'
    And param VERSION = '2.0.0'
    And param TYPENAMES = '<feature>'
    And param STARTINDEX = '0'
    And param COUNT = '1000'
    And param SRSNAME = 'urn:ogc:def:crs:EPSG::28992'
    And param filter = xmlfilter

    When method GET
    Then status 200


    Examples:
      | feature                              | prop                | value                   | resulttype |
      | kadastralekaartv4:openbareruimtenaam | tekst               | Binnenhof               | results    |
      | kadastralekaartv4:openbareruimtenaam | tekst               | Dorpstraat              | hits       |
      | kadastralekaartv4:openbareruimtenaam | tekst               | Kerkstraat              | hits       |
      | kadastralekaartv4:openbareruimtenaam | LV-publicatiedatum  | 2018-05-17T14:32:33     | hits       |
      | kadastralekaartv4:perceel            | tijdstipregistratie | 2007-09-27T10:03:38.000 | results    |
      | kadastralekaartv4:openbareruimtenaam | identificatieBAGOPR | 0678300000000183        | results    | 0678300000000180 | 0678300000000185 |
      | kadastralekaartv4:openbareruimtenaam | hoek                | 406.3                   | hits       | 406.2 | 406.4 |



  Scenario Outline:  WFS filter propertie <feature> <prop> between <van> <tot>  gives <resulttype>

    * def betweenfilter =
      """
      <Filter>
      <PropertyIsBetween>
      <PropertyName><prop></PropertyName>
      <LowerBoundary><van></LowerBoundary>
      <UpperBoundary><tot></UpperBoundary>
      </PropertyIsBetween>
      </Filter>
      """
    Given  path ''
    And param SERVICE = 'WFS'
    And param REQUEST = 'GetFeature'
    And param resulttype = '<resulttype>'
    And param VERSION = '2.0.0'
    And param TYPENAMES = '<feature>'
    And param STARTINDEX = '0'
    And param COUNT = '10000000000000'
    And param SRSNAME = 'urn:ogc:def:crs:EPSG::28992'
    And param filter = betweenfilter

    When method GET
    Then status 200

    Examples:
      | feature                              | prop                | resulttype | van                     | tot                     |
      | kadastralekaartv4:openbareruimtenaam | tekst               | results    | X                       | Y                       |
      | kadastralekaartv4:openbareruimtenaam | tekst               | hits       | A                       | Z                       |
      | kadastralekaartv4:openbareruimtenaam | tekst               | hits       | U                       | V                       |
      | kadastralekaartv4:openbareruimtenaam | LV-publicatiedatum  | hits       | 2018-05-17T00:00:00     | 2018-05-18T00:00:00     |
      | kadastralekaartv4:perceel            | tijdstipregistratie | hits       | 2007-09-27T10:03:00.000 | 2007-09-27T10:04:00.000 |
      | kadastralekaartv4:openbareruimtenaam | identificatieBAGOPR | results    | 0678300000000180        | 0678300000000185        |
      | kadastralekaartv4:openbareruimtenaam | hoek                | hits       | 406.2                   | 406.4                   |
      | kadastralekaartv4:perceel            | tijdstipregistratie | hits       | 2019-09-05T00:00:00.000 | 2019-12-25T00:00:00.000 |




