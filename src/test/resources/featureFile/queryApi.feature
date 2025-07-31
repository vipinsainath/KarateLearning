Feature: Query the URL 

Background:
* def username = 'Achari'
* def status = 'active'
* def gender = 'male'

Scenario: Fetch the user whose name contains 'Achari'
* def query = {name: 'Achari'}
Given url baseUrl + '/public/v1/users'
And params query
When method GET
Then status 200
* print response


Scenario: Fetch the user whose name contains 'Achari' and status as active
* def query = {name: 'Achari', status: 'active'}
Given url baseUrl + '/public/v1/users'
And params query
When method GET
Then status 200
* print response 


# Dynamically build query from variables - get from background
Scenario: Fetch the user with name and gender 
* def query = { name: '#(username)', gender: '#(gender)' }
Given url baseUrl + '/public/v1/users'
And params query
When method GET
Then status 200
* print response



Scenario: Fetch the user whose name contains 'Achari' and find the total counts
* def query = {name: 'Achari'}
Given url baseUrl + '/public/v1/users'
And params query
When method GET
Then status 200
* print response 
# Way one to find total count  - using length func 
* def totalCountPage1 = response.data.length  
* print 'Total count for 1 page: ',  totalCountPage1
# Way Two to find total count  - using json attribute iteself
* def totalUserCount = response.meta.pagination.total
* print 'Total count 2: ',  totalUserCount
