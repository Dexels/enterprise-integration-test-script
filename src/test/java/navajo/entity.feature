Feature: Test a basic navajo service

	Background:
		* print systemURL
		* def systemURL = 'http://navajo:8181/'
		* def baseUrl =  $systemURL
		#* def baseUrl = typeof systemURL == 'undefined' ? 'http://localhost:8181' : systemURL
		* def username = 'user'
		* def password = 'pass'
		* def tenant = 'Tenant1'
		* print "ParseURL is now: "+baseUrl
		* def consoleAuth = 'Basic YWRtaW46YWRtaW4='
		* def navajoAuth = 'Basic YTph'
		* def defaultTenant = 'Tenant1'

	Scenario: Testing an entity:
		Given url baseUrl+'/entity/movie/ActorList'
		When header Authorization = navajoAuth
		And header X-Navajo-Instance = 'Tenant1'
		And header Accept = 'application/json'
		And header X-Navajo-Version = '0'
		And method get
		Then status 200
		And match each response.Actor == {Id: '#notnull', FirstName: '#regex [A-Z][a-z]+', LastName: '#regex [A-Z][A-z-]+'}