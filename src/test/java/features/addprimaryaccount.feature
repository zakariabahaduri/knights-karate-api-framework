Feature: add primary account
  Background:
    Given url BASE_URL
    * def tokenResult = callonce read('GenerateToken.feature')
    * def validToken = "Bearer " + tokenResult.response.token

@Smoke
    Scenario:
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
      And header Authorization = validToken
      When method post
      Then status 400
      And print response
      * def expectedhttpStatus = "BAD_REQUEST"
      * def expectederrorMessage = "Account with email Bri4@yahoo.com is exist"
      And assert response.httpStatus == expectedhttpStatus
      And assert response.errorMessage == expectederrorMessage