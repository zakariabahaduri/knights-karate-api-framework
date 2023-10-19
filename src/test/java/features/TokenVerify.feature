Feature: Security token verify
  Background:
    Given url BASE_URL
  And path "/api/token"
  And request {"username": "supervisor", "password": "tek_supervisor"}
  When method post
  Then status 200
  And print response

  Scenario: send request to api/token
    And path "/api/token/verify"
    And param username = "supervisor"
    And param token = response.token
    When method get
    Then status 200
    And print response
    And assert response.message == "Token is valid"

    Scenario: Send valid username and invalid token
      And path "/api/token/verify"
      And param username = "supervisor"
      And param token = "wrong token"
      When method get
      Then status 400
      And print response
      And assert response.errorMessage == "Token Expired or Invalid Token"

      Scenario: Send invalid username and valid token
        And path "/api/token/verify"
        And param username = "wrong username"
        And param token = response.token
        When method get
        Then status 400
        And assert response.errorMessage == "Wrong Username send along with Token"