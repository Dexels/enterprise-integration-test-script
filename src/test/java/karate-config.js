function() {
  var systemURL = java.lang.System.getenv('URL');
  karate.log('System URL system property was:', systemURL);
  var evars= java.lang.System.getenv();
  karate.log(evars);
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