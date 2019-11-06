Feature: Test a basic navajo service

	Background:
		* def systemURL = 'http://navajo:8181'
		* def baseUrl =  $systemURL
		* def username = 'exampleuser'
		* def password = 'secretpassword'
		* def tenant = 'Tenant1'
		* def consoleAuth = call read('basic-auth.js') { username: 'admin', password: 'admin' }
		* def navajoAuth = call read('basic-auth.js') { username: #(username), passxword: #(password) }
		* def defaultTenant = 'Tenant1'
		* configure retry = { count: 5, interval: 500 }

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

	Scenario: Test if the system contains unresolved bundles
		Given url baseUrl+"/system/console/status-Bundles"
		When header Authorization = consoleAuth
		When method get
		Then status 200
		And match response !contains 'installed'
		And match response !contains 'Resolved'

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
		And assert response.length == 0
		And match response[0] == defaultTenant


	# Match on something better
	@#ignore for now, too noisy
	Scenario: Test if the entity documentation works
		Given url baseUrl+'/entityDocumentation/movie'
		When method get
		Then status 200
		And assert response.length > 10000

	# Match on something better
	@ignore #ignore for now, too noisy

	Scenario: Test if non existing entity documentation fails
		Given url baseUrl+'/entityDocumentation/movieaaaap'
		When method get
		Then status 200
		And assert response.length < 10000

	Scenario: Test if the monitor webapp works
		Given url baseUrl+'/Monitor/index.html'
		When method get
		Then status 200

	@ignore #The monitor does not seem to respect tenantless runs
	Scenario: Test if the monitor webapp api
		Given url baseUrl+'/monitor_api/table/Tenant1/service'
		When method get
		Then status 200
		And assert response.data.length > 1
