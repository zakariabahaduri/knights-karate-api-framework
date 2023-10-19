Feature: get/account
  Background:
    Given url BASE_URL
    * def tokenResult = callonce read('GenerateToken.feature')
    * def validToken = "Bearer " + tokenResult.response.token
    Given path "/api/accounts/get-account"


    Scenario: get/account
      * def tokenResult = callonce read('GenerateToken.feature')
      * def validToken = "Bearer " + tokenResult.response.token
      Given path "/api/accounts/get-account"
      Given param primaryPersonId = 2
      And header Authorization = validToken
      And method get
      Then status 200
      And print response
      * def expectedid = 2
      And assert response.primaryPerson.id == expectedid

  Scenario: get/account primary person id does not exist
    Given param primaryPersonId = 1200
    And header Authorization = validToken
    And method get
    Then status 404
    * def id = 1200
    And print response
    And assert response.httpStatus == "NOT_FOUND"
    And assert response.errorMessage == "Account with id " + id + " not found"


