Feature: Generate Token Feature
  Scenario: Generate Valid token
  Given url "https://qa.insurance-api.tekschool-students.com"
  And path "/api/token"
  And request {"username": "supervisor", "password": "tek_supervisor"}
  When method post
  Then status 200