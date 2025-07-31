Feature: Scenario based

Background:
* def userID = '8037229'

Scenario: Get Base URL from karate-config.js file
Given url baseUrl 
* path 'public/v2/users'					
When method GET	
* print response

Scenario: Append url with path keyword 
Given url baseUrl
* path 'public/v2/users', userID					
# actual Full url -  https://gorest.co.in/public/v2/users/8037229
When method GET
Then status 200		


Scenario: Append multiple paths
Given url baseUrl 
* path 'public/v2/users', userID					
When method GET
Then status 200		


Scenario: Print the whole Response body directly
Given url baseUrl 
* path 'public/v2/users', userID					
When method GET
Then status 200		
* print response


Scenario: Store the Response body in a variable and print 
Given url baseUrl 
* path 'public/v2/users', userID					
When method GET
Then status 200		
* def resp = response
* print resp


Scenario: Print any one attribute from the response body
Given url baseUrl 
* path 'public/v2/users', userID					
When method GET
Then status 200		
# Storing the name attribute and printing
* def jsonRespName = response.name 
* print jsonRespName
# Directly printing the status attribute
* print response.status 
