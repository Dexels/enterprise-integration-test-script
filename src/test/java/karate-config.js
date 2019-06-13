function() {
  var systemURL;
  systemURL = java.lang.System.getenv('URL');
  if(systemURL == null) {
    systemURL = "http://navajo:8181/"
  }
  if(systemURL == "") {
    systemURL = "http://navajo:8181/"
  }
  karate.log('System URL system property was:', systemURL);
  var evars= java.lang.System.getenv();
  var config = {
    systemURL: systemURL,
	  myVarName: 'someValue'
  }
//  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
//  } else if (env == 'e2e') {
    // customize
//  }
  return config;
}
