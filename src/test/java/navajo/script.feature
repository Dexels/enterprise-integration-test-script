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

	Scenario: Testing regular script with input:
		* def service = 'movie/Actor'
		Given url baseUrl+'/navajo'
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
		Given url baseUrl+'/stream'
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

	Scenario: Testing reactive script over reactive endpoint:
		* def service = 'films'
		Given url baseUrl+'/stream'
		Given request <tml><header><transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)"/></header></tml>
		When header Authorization = navajoAuth
		And header X-Navajo-Instance = tenant
		And header X-Navajo-Service =  service
		And header X-Navajo-Username = username
		And header X-Navajo-Password = password
		And method post
		Then status 200
		And match response //tml//message//message[@index='0']//property[@name='title']//@value == 'Chamber Italian'
		And match response //tml//	message//message[@index='1']//property[@name='title']//@value == 'Grosse Wonderful'