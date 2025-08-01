Feature: Verify the reponse in muliple ways
#1 verify response by $ 
#2 verify response by response
#3 verify response by GET Api


Background:
* url 'https://gorest.co.in'
# To generate unique email id everytime, we can use randomUUID()
* def emailID = 'sainath' + java.util.UUID.randomUUID() + '@gmail.com'
# Payload should be JSON type
* def requestPayload =
  """
  {
    "name": "sainath",
    "email": "#(emailID)",
    "gender": "male",
    "status": "active"
  }
  """
  
  
  
##1 Validation using $ and #present

# Postive Scenario - check for the attribute is present or not
Scenario: Create a user and verify the User ID is created and data is present or not by $ 
  Given path '/public/v1/users'
  And request requestPayload
  And header Authorization = 'Bearer ' + tokenID
  When method post
  Then status 201
  ## Validate User ID exist or not - irrespective of value
  And match $.data.id == '#present'
  And match $.data.name == 'sainath'
  ## Note  
  	#  $ - represents the entire response
  	#  #present is a matcher that asserts the key exists - means check if any value exist or not - shouldn't be empty, if empty then throw error
  	#  $.data.id = Actual data
 
	
# Negative Scenario - check for the attribute is present or not which is not created
Scenario: Create a user and verify the address is present or not by $.
  Given path '/public/v1/users'
  And request requestPayload
  And header Authorization = 'Bearer ' + tokenID
  When method post
  Then status 201
  ## Validate address exist or not - irrespective of value
  And match $.data.address == '#present'
  
  
  
##2 Validation using response body
Scenario: Create a user and verify the User ID is created and data is present or not by response body.
  Given path '/public/v1/users'
  And request requestPayload
  And header Authorization = 'Bearer ' + tokenID
  When method post
  Then status 201
  ## Get the Actual values from the response body
  * def resp = response
    # return the user id created
  * def Actual_ID = resp.data.id
  	# return the mail id generated
  * def Actual_mail = resp.data.email
    # get the status created
  * def Actual_status = resp.data.status
  * print 'USER ID: ', Actual_ID
  * print 'Email ID: ', Actual_mail
  
  ## Get expected values from the payload (post request body)
  * def expected_email = requestPayload.email
  * def expected_status = requestPayload.status
  
  ## Validation
  * match Actual_ID == '#present'
  * match Actual_mail == expected_email
	* match Actual_status == expected_status 
  
	
##3 Validation using GET Api
Scenario: Create a user with the given data and validate by Response by GET Api
  Given path '/public/v1/users'
  And request requestPayload
  And header Authorization = 'Bearer ' + tokenID
  When method post
  Then status 201
  ##Returning User ID and email id from the response
  * def postResponseJson = response
  * def post_ID = postResponseJson.data.id
  * def post_mail = postResponseJson.data.email
	
	##Validate the user id and get the email from the response and compare with expected value
	Given path '/public/v1/users/' + post_ID
	And header Authorization = 'Bearer ' + tokenID
	When method GET
	Then status 200
	## Get the User id and email from the GET Response 
	* def getResponseJson = response
	* def get_ID = getResponseJson.data.id
	* def get_mail = getResponseJson.data.email
	
	## verify with get response with post response
	* match post_ID == get_ID
	* match post_mail == get_mail
	
	
	