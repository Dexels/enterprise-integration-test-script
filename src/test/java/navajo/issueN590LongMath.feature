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
        And match response //tml//message[@name='AdditionResult']//property[@name="long_long"]//@type == 'long'
        And match response //tml//message[@name='AdditionResult']//property[@name="long_long"]//@value == '2'
        And match response //tml//message[@name='AdditionResult']//property[@name="long_int"]//@type == 'long'
        And match response //tml//message[@name='AdditionResult']//property[@name="long_int"]//@value == '2'
        And match response //tml//message[@name='AdditionResult']//property[@name="int_long"]//@type == 'long'
        And match response //tml//message[@name='AdditionResult']//property[@name="int_long"]//@value == '2'
        And match response //tml//message[@name='AdditionResult']//property[@name="long_double"]//@type == 'float'
        And match response //tml//message[@name='AdditionResult']//property[@name="long_double"]//@value == '2.0'
        And match response //tml//message[@name='AdditionResult']//property[@name="double_long"]//@type == 'float'
        And match response //tml//message[@name='AdditionResult']//property[@name="double_long"]//@value == '2.0'

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
        And match response //tml//message[@name='SubtractionResult']//property[@name="long_long"]//@type == 'long'
        And match response //tml//message[@name='SubtractionResult']//property[@name="long_long"]//@value == '1'
        And match response //tml//message[@name='SubtractionResult']//property[@name="long_int"]//@type == 'long'
        And match response //tml//message[@name='SubtractionResult']//property[@name="long_int"]//@value == '1'
        And match response //tml//message[@name='SubtractionResult']//property[@name="int_long"]//@type == 'long'
        And match response //tml//message[@name='SubtractionResult']//property[@name="int_long"]//@value == '1'
        And match response //tml//message[@name='SubtractionResult']//property[@name="long_double"]//@type == 'float'
        And match response //tml//message[@name='SubtractionResult']//property[@name="long_double"]//@value == '1.0'
        And match response //tml//message[@name='SubtractionResult']//property[@name="double_long"]//@type == 'float'
        And match response //tml//message[@name='SubtractionResult']//property[@name="double_long"]//@value == '1.0'

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
        And match response //tml//message[@name='MultiplicationResult']//property[@name="long_long"]//@type == 'long'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="long_long"]//@value == '3'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="long_int"]//@type == 'long'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="long_int"]//@value == '3'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="int_long"]//@type == 'long'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="int_long"]//@value == '3'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="long_double"]//@type == 'float'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="long_double"]//@value == '3.0'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="double_long"]//@type == 'float'
        And match response //tml//message[@name='MultiplicationResult']//property[@name="double_long"]//@value == '3.0'

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
        And match response //tml//message[@name='DivisionResult']//property[@name="long_long"]//@type == 'float'
        And match response //tml//message[@name='DivisionResult']//property[@name="long_long"]//@value == '4.0'
        And match response //tml//message[@name='DivisionResult']//property[@name="long_int"]//@type == 'float'
        And match response //tml//message[@name='DivisionResult']//property[@name="long_int"]//@value == '4.0'
        And match response //tml//message[@name='DivisionResult']//property[@name="int_long"]//@type == 'float'
        And match response //tml//message[@name='DivisionResult']//property[@name="int_long"]//@value == '4.0'
        And match response //tml//message[@name='DivisionResult']//property[@name="long_double"]//@type == 'float'
        And match response //tml//message[@name='DivisionResult']//property[@name="long_double"]//@value == '4.0'
        And match response //tml//message[@name='DivisionResult']//property[@name="double_long"]//@type == 'float'
        And match response //tml//message[@name='DivisionResult']//property[@name="double_long"]//@value == '4.0'

    Scenario: Testing Navajo issue 590 - money ops
        * def service = 'test/IssueNavajo590/InitTestMoneyOps'
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
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="money_money"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="money_money"]//@value == '15.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="money_int"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="money_int"]//@value == '15.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="int_money"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="int_money"]//@value == '15.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="money_long"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="money_long"]//@value == '15.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="long_money"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="long_money"]//@value == '15.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="money_long"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="money_long"]//@value == '15.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="money_double"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="money_double"]//@value == '15.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="double_money"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Addition']//property[@name="double_money"]//@value == '15.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="money_money"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="money_money"]//@value == '5.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="money_int"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="money_int"]//@value == '5.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="int_money"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="int_money"]//@value == '5.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="money_long"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="money_long"]//@value == '5.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="long_money"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="long_money"]//@value == '5.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="money_double"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="money_double"]//@value == '5.00'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="double_money"]//@type == 'money'
        And match response //tml//message[@name='MoneyOpsResult']//message[@name='Subtraction']//property[@name="double_money"]//@value == '5.00'

    Scenario: Testing Navajo issue 590 - percentage ops
        * def service = 'test/IssueNavajo590/InitTestPercentageOps'
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
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="percentage_percentage"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="percentage_percentage"]//@value == '15.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="percentage_int"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="percentage_int"]//@value == '15.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="int_percentage"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="int_percentage"]//@value == '15.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="percentage_long"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="percentage_long"]//@value == '15.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="long_percentage"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="long_percentage"]//@value == '15.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="percentage_double"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="percentage_double"]//@value == '15.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="double_percentage"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Addition']//property[@name="double_percentage"]//@value == '15.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="percentage_percentage"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="percentage_percentage"]//@value == '5.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="percentage_int"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="percentage_int"]//@value == '5.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="int_percentage"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="int_percentage"]//@value == '5.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="percentage_long"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="percentage_long"]//@value == '5.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="long_percentage"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="long_percentage"]//@value == '5.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="percentage_double"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="percentage_double"]//@value == '5.0'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="double_percentage"]//@type == 'percentage'
        And match response //tml//message[@name='PercentageOpsResult']//message[@name='Subtraction']//property[@name="double_percentage"]//@value == '5.0'

    Scenario: Testing Navajo issue 590 - string addition
        * def service = 'test/IssueNavajo590/InitTestStringOps'
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
        And match response //tml//message[@name='StringOpsResult']//property[@name="string_string"]//@type == 'string'
        And match response //tml//message[@name='StringOpsResult']//property[@name="string_string"]//@value == 'blabli'
        And match response //tml//message[@name='StringOpsResult']//property[@name="string_int"]//@type == 'string'
        And match response //tml//message[@name='StringOpsResult']//property[@name="string_int"]//@value == 'bla10'
        And match response //tml//message[@name='StringOpsResult']//property[@name="int_string"]//@type == 'string'
        And match response //tml//message[@name='StringOpsResult']//property[@name="int_string"]//@value == '15bla'
        And match response //tml//message[@name='StringOpsResult']//property[@name="string_long"]//@type == 'string'
        And match response //tml//message[@name='StringOpsResult']//property[@name="string_long"]//@value == 'bla10'
        And match response //tml//message[@name='StringOpsResult']//property[@name="long_string"]//@type == 'string'
        And match response //tml//message[@name='StringOpsResult']//property[@name="long_string"]//@value == '15bla'
        And match response //tml//message[@name='StringOpsResult']//property[@name="string_double"]//@type == 'string'
        And match response //tml//message[@name='StringOpsResult']//property[@name="string_double"]//@value == 'bla10.0'
        And match response //tml//message[@name='StringOpsResult']//property[@name="double_string"]//@type == 'string'
        And match response //tml//message[@name='StringOpsResult']//property[@name="double_string"]//@value == '15.0bla'
        