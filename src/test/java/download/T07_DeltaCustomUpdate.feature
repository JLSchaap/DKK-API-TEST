@SMOKE
Feature: DKK Api geeft Custom delta request voor alle leveringen
    Dit feature test alle deltas voor alle leveringen voor een specifiek interessegebied

    Scenario Outline: downoad deltas op locatie buitenhof <dkkfeaturetype>

        * print "bepaal een delta ids "
        Given url apiBaseUrl + 'kadaster/dkk/api/v1/delta'
        When method GET
        Then status 200
        And def alldelta = response.deltas
        * print "alldelta:", alldelta


        * def pararray = []
        * def featureslist = ["<dkkfeaturetype>"]

        * def fun =
            """
            function(delta) {
            req = { format: "gml", geofilter: 'POLYGON((81044.88 455429.52,81634.56000000001 455444.64,81735.36000000002 455199.36,81612.72 454955.76,81070.08 454952.4,80880.24 455192.64,81044.88 455429.52))' };

            req["deltaId"] = delta["id"];
            req["featuretypes"] = featureslist;
            pararray.add (req);
            }
            """
        * eval karate.forEach(alldelta, fun)

        * print "array:", pararray
        * print "done"
        * def dodelta = call read('DeltaCustomargs.feature') pararray

        Examples:
            | dkkfeaturetype            |
            | perceel                   |
            | kadastralegrens           |
            | perceel","kadastralegrens |
