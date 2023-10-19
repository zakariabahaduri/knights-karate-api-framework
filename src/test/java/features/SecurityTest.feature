Feature: Security Token API calls
  Scenario: send request to api/token
    Given url BASE_URL
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200

#testing with wrong username and password
  @Smoke
  Scenario: send request to api/token
    Given url BASE_URL
    And path "/api/token"
    And request {"username": "something", "password": "wrongpassword"}
    When method post
    Then status 404
    And assert response.httpStatus== "NOT_FOUND"
    And assert response.errorMessage== "User something not found"
    @Smoke
    Scenario Outline: Sending wrong usernames and passwords
      Given url BASE_URL
      And path "/api/token"
      And request
      """
      {"username": "<username>",
    "password": "<password>"}
      """
      When method post
      Then status <code_status>
      And assert response.httpStatus== "<httpStatus>"
      And assert response.errorMessage== "<errorMessage>"
      Examples:
        | username   | password       | code_status | httpStatus  | errorMessage             |
        | supervisor | adlkjf         | 400         | BAD_REQUEST | Password not matched     |
        | something  | tek_supervisor | 404         | NOT_FOUND   | User something not found |
