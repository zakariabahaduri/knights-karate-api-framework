Feature: End to End create account
  Background: Setup test get token
    Given url BASE_URL
    * def tokenResult = callonce read('GenerateToken.feature')
    * def validToken = "Bearer " + tokenResult.response.token

    @E2E
    Scenario: Create account end to end
      Given path "/api/accounts/add-primary-account"
      * def data = Java.type('data.DataGenerator')
      * def generatedemail = data.getEmail();
      And request
      """
      {
  "email": "#(generatedemail)",
  "firstName": "Smith",
  "lastName": "Lucas",
  "title": "Mr.",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Employed",
  "dateOfBirth": "1990-10-23"

}
      """
      And header Authorization = validToken
      And method post
      Then status 201
      And print response
      And print generatedemail
      And assert response.email == generatedemail

      * def id = response.id
      Given path "/api/accounts/add-account-phone"
      And header Authorization = validToken
      And param primaryPersonId = id
      And request
      """
      {
  "phoneNumber": "2034560987",
  "phoneExtension": "+!",
  "phoneTime": "day",
  "phoneType": "cell"
}
      """
      And method post
      Then status 201
      Given path "/api/accounts/add-account-car"
      And header Authorization = validToken
      And param primaryPersonId = id
      And request
      """
      {
  "make": "Toyota",
  "model": "Rav4 Hybrid",
  "year": "2024",
  "licensePlate": "AWD2314"
}
      """
      And method post
      Then status 201

      Given path "/api/accounts/add-account-address"
      And header Authorization = validToken
      And param primaryPersonId = id
      And request
      """
      {
  "addressType": "home",
  "addressLine1": "3433 1st st",
  "city": "Tukwila",
  "state": "WA",
  "postalCode": "23134",
  "countryCode": "122",
  "current": true
}
      """
   And method post
   Then status 201
   Given path "/api/accounts/delete-account"
   And header Authorization = validToken
   And param primaryPersonId = id
   And method delete
   Then status 200
   And match response == {"status": true,"httpStatus": "OK","message": "Account Successfully deleted"}