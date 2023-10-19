Feature: Inputting wrong password
  @Smoke
  Scenario: send request to api/token
    Given url BASE_URL
    And path "/api/token"
    And request {"username": "something", "password": "wrongpassword"}
    When method post
    Then status 404