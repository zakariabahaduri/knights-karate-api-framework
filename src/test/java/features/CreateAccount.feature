Feature: Create account
  Background:
    Given url "https://qa.insurance-api.tekschool-students.com"
    * def tokenResult = callonce read('GenerateToken.feature')
    * def validToken = "Bearer " + tokenResult.response.token


    Scenario: creating account
      Given path "/api/accounts/add-primary-account"
      And request
      """ {
  "email": "Bri4@yahoo.com",
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
* def expectedemail = "Bri4@yahoo.com"
And assert  response.email == expectedemail

Scenario: delete account
  Given path "/api/accounts/delete-account"
  And param primaryPersonId = 543
  And header Authorization = validToken
  And method delete
  Then status 200
  And print response
  And response.httpStatus == "OK"
  And response.message == "Account Successfully deleted"