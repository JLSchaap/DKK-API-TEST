function() {
  // karate.configure('connectTimeout', 5000);
  // karate.configure('readTimeout', 5000);
  // karate.configure('ssl', true);
  baseurl = java.lang.System.getenv('apiBaseUrl');
  if (!baseurl) {
      baseurl = 'https://download.pdok.io/' ; 
    //baseurl = 'https://downloads.pdok.nl/';
  }
  var config = { apiBaseUrl: baseurl };
  karate.log('base url :', config);
  return config;
}
