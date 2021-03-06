Feature: Test a basic navajo service

	Background:
		* def systemURL = karate.properties['navajo.address']
		* def username = 'exampleuser'
		* def password = 'secretpassword'
		* def tenant = 'Tenant1'
		* def consoleAuth = call read('basic-auth.js') { username: 'admin', password: 'admin' }
		* def navajoAuth = call read('basic-auth.js') { username: #(username), passxword: #(password) }
		* def defaultTenant = 'Tenant1'


	Scenario: Testing regular script:
		* def service = 'movie/ActorList'
		Given url systemURL+'/navajo'
		Given request <tml><header><transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)"/></header></tml>
		When header Authorization = navajoAuth
		And header X-Navajo-Instance = tenant
		And header X-Navajo-Service =  service
		And header X-Navajo-Username = username
		And header X-Navajo-Password = password
		And method post
		Then status 200
		And match response //tml//message[@name='ActorList']//message[@name='Actor']//message[@index='1']//property[@name='FirstName']//@value == 'Nick'
		And match response //tml//message//message//message[@index='2']//property[@name='FirstName']//@value == 'Ed'

	Scenario: Testing tenantless and authless:
		* def service = 'InitTest'
		Given url systemURL+'/navajo'
		Given request <tml><header><transaction rpc_name="#(service)"/></header></tml>
		When  header X-Navajo-Service =  service
		And header X-Navajo-Instance = tenant
		And method post
		Then status 200
		And match response //tml//message[@name='error'] == '#notpresent'
		And match response //tml//message[@name='pipo'] == '#present'

	Scenario: Testing service that should time out:
		* def service = 'InitSleep'
		Given url systemURL+'/navajo'
		Given request <tml><header><transaction rpc_name="#(service)"/></header></tml>
		When  header X-Navajo-Service =  service
		And header X-Navajo-Instance = tenant
		And method post
		Then status 500

	Scenario: Testing regular script with input:
		* def service = 'movie/Actor'
		Given url systemURL+'/navajo'
		Given request
			"""
			<tml>
			<header>
			<transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)"/>
			</header>
			<message name="Actor">
			<property name="Id" value="4" type="integer"/>
			</message>
			</tml>
			"""
		When header Authorization = navajoAuth
		And header X-Navajo-Instance = tenant
		And header X-Navajo-Service =  service
		And header X-Navajo-Username = username
		And header X-Navajo-Password = password
		And method post
		Then status 200
		And match response //tml//message//property[@name='FirstName']//@value == 'Jennifer'


	Scenario: Testing regular script over reactive endpoint:
		* def service = 'movie/ActorList'
		Given url systemURL+'/stream'
		Given request <tml><header><transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)"/></header></tml>
		When header Authorization = navajoAuth
		And header X-Navajo-Instance = tenant
		And header X-Navajo-Service =  service
		And header X-Navajo-Username = username
		And header X-Navajo-Password = password
		And header Accept-Encoding = "identity"
		And method post
		Then status 200
		And match response //tml//message//message//message[@index='1']//property[@name='FirstName']//@value == 'Nick'
		And match response //tml//message//message//message[@index='2']//property[@name='FirstName']//@value == 'Ed'

	Scenario: Testing reactive script over reactive endpoint:
		* def service = 'films'
		Given url systemURL+'/stream'
		Given request <tml><header><transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)"/></header></tml>
		When header Authorization = navajoAuth
		And header X-Navajo-Instance = tenant
		And header X-Navajo-Service =  service
		And header X-Navajo-Username = username
		And header X-Navajo-Password = password
		And header Accept-Encoding = "identity"
		And method post
		Then status 200
		And match response //tml//message//message[@index='0']//property[@name='title']//@value == 'Chamber Italian'
		And match response //tml//	message//message[@index='1']//property[@name='title']//@value == 'Grosse Wonderful'

	Scenario: Testing access store to see if actual access objects are showing up:
		* def service = 'navajo/AccessCount'
		Given url systemURL+'/navajo'
		Given request <tml><header><transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)"/></header></tml>
		When header Authorization = navajoAuth
		And header X-Navajo-Instance = tenant
		And header X-Navajo-Service =  service
		And header X-Navajo-Username = username
		And header X-Navajo-Password = password
		And method post
		Then status 200
		* remove response  /tml/header
		* def count = $response // @value
		* print "Count is :"+(count > 4)
		* assert count > 0

