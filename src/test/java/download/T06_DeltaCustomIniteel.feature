@SMOKE
Feature: DKK Api geeft Custom delta initial request
  Dit feature test zowel de intiele download voor een specifiek interessegebied

  Scenario Outline: downoad delta initial locatie buitenhof <dkkfeaturetype>

    * def requestparams = {format: "gml",featuretypes: ["<dkkfeaturetype>"],  geofilter: 'POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))' }
    * print "Initeel:", requestparams
    * def dodelta = call read('DeltaCustomargs.feature') requestparams

    Examples:
      | dkkfeaturetype            |
      | perceel                   |
      | kadastralegrens           |
      | perceel","kadastralegrens |