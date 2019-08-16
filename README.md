# DKK-API-TEST [![Build Status](https://travis-ci.org/JLSchaap/DKK-API-TEST.svg?branch=master)](https://travis-ci.org/JLSchaap/DKK-API-TEST)

This project is a test project for the [PDOK DKK download API](https://downloads.pdok.nl/kadastralekaart/api/v4_0/ui/).
The [DKK download viewer](https://downloads.pdok.nl/kadastralekaart/viewer/) is the standard web interface for the "Full" and "Custom" calls of this API.
With Java, Maven and [Karate](https://github.com/intuit/karate) the API is tested inclusive the "Delta" calls.

Test are run with the following commands:

``` bash
git clone https://github.com/JLSchaap/DKK-API-TEST
mvn test
```

[a cucumber test report](https://jlschaap.github.io/DKK-API-TEST/cucumber-html-reports/overview-features.html) shows the status of the last succesfull [Travis test](https://travis-ci.org/JLSchaap/DKK-API-TEST) run on the API. 
Download urls created by this testrun can be found in the files generated during the tests:  

* [fullcustomtest](https://jlschaap.github.io/DKK-API-TEST/fullcustomurl.yaml)
* [HeelNederlandDkk](https://jlschaap.github.io/DKK-API-TEST/T03HeelNederlandDkk.yaml)
* [initialdelta](https://jlschaap.github.io/DKK-API-TEST/T03HeelNederlandInitieleDeltaDkk.yaml)


All test are run in parallel as shown in the [timeline](https://jlschaap.github.io/DKK-API-TEST/timeline.html) for the latest run.

