Feature: Create a user and then delete the same user

Background:
* def extPath = '/public/v1/users'
* def randomEmail = 'vipin' + java.util.UUID.randomUUID() + '@gmail.com'									 
* def postReqBody = read('classpath:payload/createUser.json')
* set postReqBody.email = randomEmail


Scenario: Create a user and delete the same user 
###1 Create a user using post call
Given url baseUrl
And path extPath
And header Authorization = 'Bearer ' + tokenID 
And request postReqBody
When method post
Then status 201
* def created_ID = response.data.id
* def created_email = response.data.email
* def created_status = response.data.status
* def created_gender = response.data.gender

# Validation
* match created_ID == '#present' 
* match created_email == randomEmail
* match created_status == 'active'
* match created_gender == 'male'
* print 'Created ID: ', created_ID, ' Created Email: ', created_email, ' Created Status: ', created_status, ' Created Gender: ', created_gender

* print 'user got created successfully' 

###2 Verify the created user exist using GET Call
Given url baseUrl 
And path extPath, created_ID
And header Authorization = 'Bearer ' + tokenID
When method get
Then status 200 

# Validation
* match $.data.id == created_ID
* match $.data.email == created_email
* match $.data.status == created_status
* match $.data.gender == created_gender
* print 'user got verified successfully after created' 


###3 Delete the user 
Given url baseUrl
And path extPath, created_ID
And header Authorization = 'Bearer ' + tokenID
When method delete
Then status 204
* print 'user got deleted successfully' 

###4 Verify the user got delete or not
Given url baseUrl
And path extPath, created_ID
And header Authorization = 'Bearer ' + tokenID
When method get
Then status 404
* match $.data.message == 'Resource not found' 
* print 'user got verified successfully after deleted' 