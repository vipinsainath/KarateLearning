Feature: GET api call

Background:
* def userID = '8037230'

Scenario: Get specific User Details - print whole response body 
Given url 'https://gorest.co.in/public/v2/users'
* path userID					
When method GET
Then status 200		
* print response
* def jsonResp = response 
* print jsonResp


Scenario: Get specific User Details - print attribute from response body 
Given url 'https://gorest.co.in/public/v2/users'
* path userID						
When method GET
Then status 200		
* def jsonRespName = response.name 
* print jsonRespName


Scenario: Get All User Details - fetch the ID from the 1st json data set
Given url 'https://gorest.co.in/public/v2/users'				
When method GET
Then status 200		
* print response 
* def userID = response[0].id
* print 'First ID is:', userID


Scenario: Get All User Details - fetch the total user counts and next link - nested json
Given url 'https://gorest.co.in/public/v1/users'				
When method GET
Then status 200		
* print response 
* print TotalUserCounts = response.meta.pagination.total
* print nextLink = response.meta.pagination.links.next
* print previousLink = response.meta.pagination.links[0]	
# Either way we can access by indexing [0] or by navigating through attribute name		
* print 'Total User Counts: ', TotalUserCounts, ' Next Page Link: ', nextLink, ' Previous Link: ', previousLink



Scenario: Get specific User Details - response verify attribute - using match keyword
Given url 'https://gorest.co.in/public/v2/users'
* path userID						
When method GET
Then status 200	
* def actualID = response.id	
* def actualName = response.name
* def actualEmail = response.email
* def actualGender = response.gender
* def actualStatus = response.status

* print 'Actual user ID:', actualID
* print 'Actual user Name:', actualName
* print 'Actual user Email:', actualEmail
* print 'Actual user Gender:', actualGender
* print 'Actual user Status:', actualStatus

 ##Validation 
* match actualID == 8037254
* match actualName == 'Chandraprabha Guha' 
* match actualEmail == 'chandraprabha_guha@bailey.test' 
* match actualGender == 'male' 
* match actualStatus == 'inactive' 















