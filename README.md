# DKK-API-TEST [![Build Status](https://travis-ci.org/JLSchaap/DKK-API-TEST.svg?branch=master)](https://travis-ci.org/JLSchaap/DKK-API-TEST)

This project is a test project for the [PDOK DKK download API](https://downloads.pdok.nl/kadastralekaart/api/v4_0/ui/).
The [DKK download viewer](https://downloads.pdok.nl/kadastralekaart/viewer/) is the standard web interface for the "Full" and "Custom" calls of this API.
With Java, Maven and [Karate](https://github.com/intuit/karate) the API is tested inclusive the "Delta" calls.

Test are run with the following commands:

``` bash
git clone https://github.com/JLSchaap/DKK-API-TEST
mvn test
```

[A cucumber test report](https://jlschaap.github.io/DKK-API-TEST/cucumber-html-reports/overview-features.html) shows the status of the last succesfull [Travis test](https://travis-ci.org/JLSchaap/DKK-API-TEST) run on the API. 
Download urls (zips) created by the API during this testrun can be found in the log files generated during the tests:  

* [Fullcustomtest](https://jlschaap.github.io/DKK-API-TEST/fullcustomurl.yaml)
* [HeelNederlandDkk](https://jlschaap.github.io/DKK-API-TEST/T03HeelNederlandDkk.yaml)
* [Initialdelta](https://jlschaap.github.io/DKK-API-TEST/T03HeelNederlandInitieleDeltaDkk.yaml)


All test are run in parallel as shown in the [timeline](https://jlschaap.github.io/DKK-API-TEST/timeline.html) for the latest run.

