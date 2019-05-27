function() {
  // karate.configure('connectTimeout', 5000);
  // karate.configure('readTimeout', 5000);
  baseurl = java.lang.System.getenv('apiBaseUrl'); 
  if (!baseurl) {
    baseurl = 'https://download.pdok.io/kadaster/dkk/api/v1' ; 
  }
  var config = { apiBaseUrl: baseurl };
  karate.log('base url :', config);
  return config;
}