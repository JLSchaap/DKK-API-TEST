function() {
  // karate.configure('connectTimeout', 5000);
  // karate.configure('readTimeout', 5000);
  karate.configure('ssl', true);
  karate.configure('retry',{ count:20, interval:5000});
  baseurl = java.lang.System.getenv('apiBaseUrl');
  if (!baseurl) {
    //   old baseurl = 'https://download.pdok.io/kadaster/dkk/api/v1' ; 
    baseurl = 'https://downloads.pdok.nl/';
  }
  var config = { apiBaseUrl: baseurl };
  karate.log('base url :', config);
  return config;
}