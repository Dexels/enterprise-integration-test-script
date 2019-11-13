Feature: Test a basic navajo service

	Background:
		* def systemURL = karate.properties['navajo.address']
		* def baseUrl =  URL
		* def username = 'exampleuser'
		* def password = 'secretpassword'
		* def tenant = 'Tenant1'
		* def consoleAuth = call read('basic-auth.js') { username: 'admin', password: 'admin' }
		* def navajoAuth = call read('basic-auth.js') { username: #(username), passxword: #(password) }
		* def defaultTenant = 'Tenant1'

	Scenario: Testing an entity:
		Given url baseUrl+'/entity/movie/ActorList'
		* print ( 'sys: '+url)
		When header Authorization = navajoAuth
		And header X-Navajo-Instance = 'Tenant1'
		And header Accept = 'application/json'
		And header X-Navajo-Version = '0'
		And method get
		Then status 200
		And match each response.Actor == {Id: '#notnull', FirstName: '#regex [A-Z][a-z]+', LastName: '#regex [A-Z][A-z-]+'}