Feature: Test issue 518

    Background:
        * def systemURL = karate.properties['navajo.address']
        * def tenant = 'Tenant1'
        * def username = 'exampleuser'
        * def password = 'secretpassword'
        * def navajoAuth = call read('basic-auth.js') { username: #(username), password: #(password) }

    Scenario: Testing issue518 - no send through field
        * def service = 'test/Issue518/TestCallerNone'
        Given url systemURL + '/navajo'
        Given request
            """
            <tml>
              <header>
                <transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)"/>
              </header>
              <message name="SimpleMessage1">
                <property name="Name1" type="string" value="Value1" direction="in"/>
              </message>
              <message scope="global" name="SimpleMessage2">
                <property name="Name2" type="string" value="Value2" direction="in"/>
              </message>
              <message scope="local" name="SimpleMessage3">
                <property name="Name3" type="string" value="Value3" direction="in"/>
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
        And match response count(//tml//message[@name='NoParameter']//message//message[@name='SimpleMessage1']) == 0
        And match response //tml//message[@name='NoParameter']//message//message[@name='SimpleMessage2']//property//@value == 'Value2'
        And match response count(//tml//message[@name='NoParameter']//message//message[@name='SimpleMessage3']) == 0

    Scenario: Testing issue518 - false send through field
        * def service = 'test/Issue518/TestCallerFalse'
        Given url systemURL + '/navajo'
        Given request
            """
            <tml>
              <header>
                <transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)"/>
              </header>
              <message name="SimpleMessage1">
                <property name="Name1" type="string" value="Value1" direction="in"/>
              </message>
              <message scope="global" name="SimpleMessage2">
                <property name="Name2" type="string" value="Value2" direction="in"/>
              </message>
              <message scope="local" name="SimpleMessage3">
                <property name="Name3" type="string" value="Value3" direction="in"/>
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
        And match response count(//tml//message[@name='FalseParameter']//message//message[@name='SimpleMessage1']) == 0
        And match response //tml//message[@name='FalseParameter']//message//message[@name='SimpleMessage2']//property//@value == 'Value2'
        And match response count(//tml//message[@name='FalseParameter']//message//message[@name='SimpleMessage3']) == 0
    
    Scenario: Testing issue518 - true send through field
        * def service = 'test/Issue518/TestCallerTrue'
        Given url systemURL + '/navajo'
        Given request
            """
            <tml>
              <header>
                <transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)"/>
              </header>
              <message name="SimpleMessage1">
                <property name="Name1" type="string" value="Value1" direction="in"/>
              </message>
              <message scope="global" name="SimpleMessage2">
                <property name="Name2" type="string" value="Value2" direction="in"/>
              </message>
              <message scope="local" name="SimpleMessage3">
                <property name="Name3" type="string" value="Value3" direction="in"/>
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
        And match response //tml//message[@name='TrueParameter']//message//message[@name='SimpleMessage1']//property//@value == 'Value1'
        And match response //tml//message[@name='TrueParameter']//message//message[@name='SimpleMessage2']//property//@value == 'Value2'
        And match response count(//tml//message[@name='TrueParameter']//message//message[@name='SimpleMessage3']) == 0
