Feature: Upadate the status for newly created user

Background:
* def extPath = '/public/v1/users'
* def randomEmail = 'vipin' + java.util.UUID.randomUUID() + '@example.com'
* def requestPayload = read('classpath:payload/createUser.json')
* requestPayload.email = randomEmail


Scenario: Create a user account and update status using PUT call
	Given url baseUrl 
	And path extPath
	And request requestPayload
	And header Authorization = 'Bearer ' + tokenID
	When method post
	Then status 201

## Returning the ID, mail, status:
	* def created_ID = response.data.id
	* def created_email = response.data.email
	* def created_status = response.data.status
	* print 'Created ID: ',created_ID,  ' Created Email: ',created_email, ' Created Status: ', created_status
	
## Validation after created
	* match created_ID == '#present'
	* match created_email == '#present' 
	* match created_status == '#present'
	* match created_email contains 'vipin'
	* match created_status contains 'active' 

## Update the status to inactive
	 ## payload
	 * def statusPayload = read('classpath:payload/status.json')
	
	 # Conditional logic to update status
	 * def newStatus = (created_status == 'active') ? 'inactive' : 'active'
   * set statusPayload.status = newStatus
	
	 # Now make the PUT request
	 Given url baseUrl
	 And path extPath, created_ID
	 And header Authorization = 'Bearer ' + tokenID
	 And request statusPayload
   When method put
   Then status 200
   And match $.data.id == created_ID
	 And match $.data.email == created_email
	 * def updated_Status = response.data.status
	 * print '1st Updated Status: ', response.data.status 
	 
## Again Update the status to active  
	
	 # Conditional logic to update status
	 * def newStatus2 = (updated_Status == 'active') ? 'inactive' : 'active'
   * set statusPayload.status = newStatus2
	
	 # Now make the PUT request
	 Given url baseUrl
	 And path extPath, created_ID
	 And header Authorization = 'Bearer ' + tokenID
	 And request statusPayload
   When method put
   Then status 200
	 * print '2nd Updated Status: ', response.data.status 	
	
	