Feature: getting the whole table in the plans
  Background:
    Given url "https://qa.insurance-api.tekschool-students.com"
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def vaildToken = "Bearer " + response.token



    Scenario: send GET request to /api/plans/get-all-plan-code
      And path "/api/plans/get-all-plan-code"
      And header Authorization = vaildToken
      When method get
      Then status 200
      And print response
      And assert response[0].planType == "MOTORCYCLE"
      And assert response[0].planExpired == false
      And assert response[1].planExpired == false
      And assert response[2].planExpired == false
      And assert response[3].planExpired == false

