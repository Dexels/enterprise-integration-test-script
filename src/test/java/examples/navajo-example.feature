Feature: Test a basic navajo service

	Background:
		* print systemURL
		* def systemURL = 'http://navajo:8181/'
		* def baseUrl =  $systemURL
		#* def baseUrl = typeof systemURL == 'undefined' ? 'http://localhost:8181' : systemURL
		* def username = 'user'
		* def password = 'pass'
		* def tenant = 'Tenant1'
		* print "PaseURL is now: "+baseUrl
		* def consoleAuth = 'Basic YWRtaW46YWRtaW4='
		* def navajoAuth = 'Basic YTph'
		* def defaultTenant = 'Tenant1'

	Scenario: Test if the navajo tester is available
		Given url baseUrl+"/tester.html"
		* print "Using url: "+baseUrl+"/tester.html"
		When method get
		Then status 200

	Scenario: Test if the system console is available
		Given url baseUrl+"/system/console"
		* print "Using url: "+baseUrl+"/system/console"
		When header Authorization = consoleAuth
		When method get
		Then status 200

	Scenario: Test if the navajo tester backend is available
		Given url baseUrl+'/testerapi?query=getscripts'
		When method get
		Then status 200
		And match response == '#[]'
		And match response == '#[_>4]'

	Scenario: Test if the navajo tenants are what we expect:
		Given url baseUrl+'/testerapi?query=gettenants'
		When method get
		Then status 200
		And assert response.length == 1
		And match response[0] == defaultTenant

	Scenario: Testing an entity:
		Given url baseUrl+'/entity/movie/ActorList'
		When header Authorization = navajoAuth
		And header X-Navajo-Instance = 'Tenant1'
		And header Accept = 'application/json'
		And header X-Navajo-Version = '0'
		And method get
		Then status 200
		And match each response.Actor == {Id: '#notnull', FirstName: '#regex [A-Z][a-z]+', LastName: '#regex [A-Z][A-z-]+'}

	Scenario: Testing regular script:
		* def service = 'movie/ActorList'
		Given url baseUrl+'/navajo'
		Given request <tml><header><transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)"/></header></tml>
		When header Authorization = navajoAuth
		And header X-Navajo-Instance = tenant
		And header X-Navajo-Service =  service
		And header X-Navajo-Username = username
		And header X-Navajo-Password = password
		And method post
		Then status 200
		And match response //tml//message//message//message[@index='1']//property[@name='FirstName']//@value == 'Nick'
		And match response //tml//message//message//message[@index='2']//property[@name='FirstName']//@value == 'Ed'
