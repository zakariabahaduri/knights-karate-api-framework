Feature: Inputting wrong password
  Scenario: send request to api/token
    Given url "https://qa.insurance-api.tekschool-students.com"
    And path "/api/token"
    And request {"username": "something", "password": "wrongpassword"}
    When method post
    Then status 404