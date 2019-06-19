# DKK-API-TEST [![Build Status](https://travis-ci.org/JLSchaap/DKK-API-TEST.svg?branch=master)](https://travis-ci.org/JLSchaap/DKK-API-TEST)

This project is a test project for the [PDOK DKK download API](https://downloads.pdok.nl/kadaster/dkk/api/v1/ui/).
The [DKK download viewer](https://downloads.pdok.nl/kadaster/dkk/viewer/) is the standard web interface for the "Full" and "Custom" calls of this API.
With Java, Maven and [Karate](https://github.com/intuit/karate) the API is tested inclusive the "Delta" calls.

Test are run the following commands:

``` bash
git clone https://github.com/JLSchaap/DKK-API-TEST
mvn test
'''


[Details on Latest Travis test results for testing the DKK-API](https://jlschaap.github.io/DKK-API-TEST/cucumber-html-reports/overview-features.html)

[Test are run in parallel this is shown in the timeline](https://jlschaap.github.io/DKK-API-TEST/timeline.html)
