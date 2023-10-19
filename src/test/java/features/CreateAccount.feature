Feature: Create account
  Background:
    Given url BASE_URL
    * def tokenResult = callonce read('GenerateToken.feature')
    * def validToken = "Bearer " + tokenResult.response.token

    @Smoke
    Scenario: creating account
      Given path "/api/accounts/add-primary-account"
      * def email = "Bri8@yahoo.com"
      And request
      """ {
  "email": "#(email)",
  "firstName": "Bri",
  "lastName": "Robinson",
  "title": "Mr.",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Employed",
  "dateOfBirth": "1990-10-22"

} """
When method post
Then status 201
And print response
And assert  response.email == email
Given path "/api/accounts/delete-account"
And param primaryPersonId = response.id
And header Authorization = validToken
And method delete
Then status 200
And print response
And response.httpStatus == "OK"
And response.message == "Account Successfully deleted"

