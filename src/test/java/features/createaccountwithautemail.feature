Feature: add account with auto email generator
  Background:
    Given url BASE_URL
    * def tokenResult = callonce read('GenerateToken.feature')
    * def validToken = "Bearer " + tokenResult.response.token
    @Smoke
    Scenario: Create account with random email
      Given path "/api/accounts/add-primary-account"
      * def datagenerator = Java.type('data.DataGenerator')
      * def autoemail = datagenerator.getEmail();
      * def firstname = datagenerator.getFirstName();
      And request
      """ {
  "email": "#(autoemail)",
  "firstName": "#(firstname)",
  "lastName": "Thompson",
  "title": "Mr.",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Employed",
  "dateOfBirth": "1990-10-22"

} """

      When method post
      Then status 201
      And print response