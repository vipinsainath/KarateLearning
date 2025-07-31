Feature: GET api call

Background: 
* def baseURI = 'https://gorest.co.in/public/v2/users'
* def userID = 8037229

Scenario: Get All User Details 
# get all users list
Given url 'https://gorest.co.in/public/v2/users' 
When method GET
Then status 200
* print "Get All user details"


#Negative Validation - fetch user detail which is not available - exp status 404 
Scenario: Get specific User Details - User not found
Given url baseURI
* path '123'						
When method GET
Then status 404		



