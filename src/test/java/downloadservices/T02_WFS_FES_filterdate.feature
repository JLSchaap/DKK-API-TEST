@WIP
Feature: DKK WFS FES Filter test

  Background:
    * url 'http://geodata.nationaalgeoregister.nl/kadastralekaart/wfs/v4_0'
    * configure readTimeout = 240000


  Scenario Outline:  aan WFS filter propertie <feature> <prop> between <van> <tot>  gives <resulttype>

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
      | feature                           | prop                | resulttype | van                     | tot                     |
      | kadastralekaartv4:perceel         | tijdstipregistratie | hits       | 2019-08-29T17:40:05.000 | 2019-08-30T17:40:05.000 |
      | kadastralekaartv4:kadastraleGrens | tijdstipregistratie | hits       | 2019-08-29T17:40:05.000 | 2019-08-30T17:40:05.000 |
      | kadastralekaartv4:perceel         | tijdstipregistratie | hits       | 2019-09-01T17:40:05.000 | 2019-09-02T00:00:00.000 |
      | kadastralekaartv4:kadastraleGrens | tijdstipregistratie | hits       | 2019-09-01T17:40:05.000 | 2019-09-02T00:00:00.000 |
      | kadastralekaartv4:perceel         | tijdstipregistratie | hits       | 2019-09-02T00:00:00.000 | 2019-09-03T00:00:00.000 |
      | kadastralekaartv4:kadastraleGrens | tijdstipregistratie | hits       | 2019-09-02T00:00:00.000 | 2019-09-03T00:00:00.000 |
      | kadastralekaartv4:perceel         | tijdstipregistratie | hits       | 2019-09-05T00:00:00.000 | 2019-09-06T00:00:00.000 |
      | kadastralekaartv4:kadastraleGrens | tijdstipregistratie | hits       | 2019-09-05T00:00:00.000 | 2019-09-06T00:00:00.000 |



