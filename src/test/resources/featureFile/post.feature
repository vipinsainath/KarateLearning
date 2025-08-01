Feature: Create user using post api

# For clarity of $ - checkout verifyTheResponse.feature 


Background:
* url 'https://gorest.co.in'
# To generate unique email id everytime, we can use randomUUID()
* def emailID = 'vipin' + java.util.UUID.randomUUID() + '@gmail.com'
# Payload should be JSON type
* def requestPayload =
  """
  {
    "name": "vipin",
    "email": "#(emailID)",
    "gender": "male",
    "status": "active"
  }
  """

Scenario: Create a user with the given data and return the USER ID
  Given path '/public/v1/users'
  And request requestPayload
  And header Authorization = 'Bearer ' + tokenID
  When method post
  Then status 201
  ##Returning User ID
  * def userID = response.data.id
  * print 'USER ID: ', userID
  ##Validation
  And match $.data.id == '#present'
  And match $.data.name == '#present'
  And match $.data.name == requestPayload.name
  * print requestPayload.name
	* print requestPayload.email
	

Scenario: Create a user with the given data and validate by Response and by GET Api
  Given path '/public/v1/users'
  And request requestPayload
  And header Authorization = 'Bearer ' + tokenID
  When method post
  Then status 201
  
  # Returning User ID
  * def respJson = response
  * def userID = respJson.data.id
  * def emailID = respJson.data.email
  * print 'USER ID: ', userID
  * print 'Email ID: ', emailID
  
  # Validation by Response
  And match respJson.data.id == '#present'
  And match respJson.data.name == '#present'
  And match respJson.data.name == 'vipin'
	
	# Validating by GET Api
	Given path '/public/v1/users/' + userID
	And header Authorization = 'Bearer ' + tokenID
	When method GET
	Then status 200
	And match response.data.id == userID
	And match response.data.email == emailID
  
 
Scenario: Create user by reading payload from external file (.json)

	* def requestPayload = read('classpath:payload/createUser.json')
	## replace the email dynamically
	* requestPayload.email = 'vipin' + java.util.UUID.randomUUID() + '@example.com'
	
  Given path '/public/v1/users'
  And header Authorization = 'Bearer ' + tokenID
  And request requestPayload
  When method post
  Then status 201
  * print 'User Created: ', response.data.id
  

Scenario: Create user by reading payload from external file (.js)

	* def requestPayload = call read('classpath:payload/createUser2.js')
	## replace the email dynamically
	* requestPayload.email = 'vipin' + java.util.UUID.randomUUID() + '@gmail.com'
	
  Given path '/public/v1/users'
  And header Authorization = 'Bearer ' + tokenID
  And request requestPayload
  When method post
  Then status 201
  * print 'User Created: ', response.data.id




  
## Note 
# Keywords used - request, post
# request followed by request body variable


## Note - status code 
# 422 - Unprocessable Entity,  server understood the request, but the data you sent was invalid or could not be processed. 
#			  will get this if the data is already created. 


## Note - match
# match respJson.data.id == '#present' 
# #present --> any data should be present

## Note:
# Payload should be JSON Type - because we have given "Accept: 'application/json'" in the header


## Read external file
# .json file -> * def requestPayload = read('classpath:payload/createUser.json')
# .js file -> * def requestPayload = call read('classpath:payload/createUser2.js')
# for .js file, we must use call function