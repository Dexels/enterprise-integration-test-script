function conf() {
  var address = karate.properties["navajo.address"]; // get java system property 'karate.env'

  if (!address) {
    karate.properties["navajo.address"] = "http://navajo:8181";
  }

  karate.log("props:", karate.properties["navajo.address"]);
  karate.configure("connectTimeout", 10000);
  karate.configure("readTimeout", 10000);
  //  if (env == 'dev') {
  // customize
  // e.g. config.foo = 'bar';
  //  } else if (env == 'e2e') {
  // customize
  //  }
  var config = {};
  config.URL = karate.properties["navajo.address"];
  return config;
}
