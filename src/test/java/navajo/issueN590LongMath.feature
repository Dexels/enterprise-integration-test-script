Feature: Test Navajo issue 590

    Background:
        * def systemURL = karate.properties['navajo.address']
        * def tenant = 'Tenant1'
        * def username = 'exampleuser'
        * def password = 'secretpassword'
        * def navajoAuth = call read('basic-auth.js') { username: #(username), password: #(password) }

    Scenario: Testing Navajo issue 590 - long addition
        * def service = 'test/IssueNavajo590/InitTestLongAdd'
        Given url systemURL + '/navajo'
        Given request
            """
            <tml>
              <header>
                <transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)" />
              </header>
              <message name="Request" />
            </tml>
            """
        When header Authorization = navajoAuth
        And header X-Navajo-Instance = tenant
        And header X-Navajo-Service =  service
        And header X-Navajo-Username = username
        And header X-Navajo-Password = password
        And method post
        Then status 200
        And match response //tml//message[@name='AdditionResult']//property[@name="longxlong"]//@value == '2'
        And match response //tml//message[@name='AdditionResult']//property[@name="longxint"]//@value == '2'
        And match response //tml//message[@name='AdditionResult']//property[@name="intxlong"]//@value == '2'
        And match response //tml//message[@name='AdditionResult']//property[@name="longxdouble"]//@value == '2.0'
        And match response //tml//message[@name='AdditionResult']//property[@name="doublexlong"]//@value == '2.0'

    Scenario: Testing Navajo issue 590 - long subtraction
        * def service = 'test/IssueNavajo590/InitTestLongSub'
        Given url systemURL + '/navajo'
        Given request
            """
            <tml>
              <header>
                <transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)" />
              </header>
              <message name="Request" />
            </tml>
            """
        When header Authorization = navajoAuth
        And header X-Navajo-Instance = tenant
        And header X-Navajo-Service =  service
        And header X-Navajo-Username = username
        And header X-Navajo-Password = password
        And method post
        Then status 200
        And match response //tml//message[@name='SubtractionResult']//property[@name="longxlong"]//@value == '1'
        And match response //tml//message[@name='SubtractionResult']//property[@name="longxint"]//@value == '1'
        And match response //tml//message[@name='SubtractionResult']//property[@name="intxlong"]//@value == '1'
        And match response //tml//message[@name='SubtractionResult']//property[@name="longxdouble"]//@value == '1.0'
        And match response //tml//message[@name='SubtractionResult']//property[@name="doublexlong"]//@value == '1.0'

    Scenario: Testing Navajo issue 590 - long multiplication
        * def service = 'test/IssueNavajo590/InitTestLongMult'
        Given url systemURL + '/navajo'
        Given request
            """
            <tml>
              <header>
                <transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)" />
              </header>
              <message name="Request" />
            </tml>
            """
        When header Authorization = navajoAuth
        And header X-Navajo-Instance = tenant
        And header X-Navajo-Service =  service
        And header X-Navajo-Username = username
        And header X-Navajo-Password = password
        And method post
        Then status 200
        And match response //tml//message[@name='MultiplicationResult']//property[@name="longxlong"]//@value == '3'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="longxint"]//@value == '3'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="intxlong"]//@value == '3'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="longxdouble"]//@value == '3.0'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="doublexlong"]//@value == '3.0'

    Scenario: Testing Navajo issue 590 - long division
        * def service = 'test/IssueNavajo590/InitTestLongDiv'
        Given url systemURL + '/navajo'
        Given request
            """
            <tml>
              <header>
                <transaction rpc_pwd="#(password)" rpc_name="#(service)" rpc_usr="#(username)" />
              </header>
              <message name="Request" />
            </tml>
            """
        When header Authorization = navajoAuth
        And header X-Navajo-Instance = tenant
        And header X-Navajo-Service =  service
        And header X-Navajo-Username = username
        And header X-Navajo-Password = password
        And method post
        Then status 200
        And match response //tml//message[@name='DivisionResult']//property[@name="longxlong"]//@value == '4.0'
        And match response //tml//message[@name='DivisionResult']//property[@name="longxint"]//@value == '4.0'
        And match response //tml//message[@name='DivisionResult']//property[@name="intxlong"]//@value == '4.0'
        And match response //tml//message[@name='DivisionResult']//property[@name="longxdouble"]//@value == '4.0'
        And match response //tml//message[@name='DivisionResult']//property[@name="doublexlong"]//@value == '4.0'
