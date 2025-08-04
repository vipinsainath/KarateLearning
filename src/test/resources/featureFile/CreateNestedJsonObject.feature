Feature: create nested json object

@ignore
Scenario: create a simple json Object
* set payloadSimpleJson 
	 |path|value|
	 |name|'vipin'|
	 |age|30|
	 |email| "vipin's@gmail.com"| 
	 
* print payloadSimpleJson

@ignore
Scenario: create a nested json object

* set payloadNestedJson
		 |path|value|
		 |Name|'vipin'|
		 |Age|30|
		 |Contact.Address.DoorNo| '28/56' |
		 |Contact.Address.Street| 'karate testing street' |
		 |Contact.Address.Pincode| 6000078 |
		 |Contact.PhoneNo| 569874632 |
		 |Contact.Email| "vipin's@gmail.com" | 	
		 
* print payloadNestedJson


@ignore
Scenario: create a nested json object and array 

* set payloadNestedJson
		 |path|value|
		 |Name|'vipin'|
		 |Age|30|
		 |Contact.Address[0].Permanent.Street| 'karate testing street' |
		 |Contact.Address[0].Permanent.City| 'Chennai' |
		 |Contact.Address[1].Temporary.Street| 'karate street' |
		 |Contact.Address[1].Temporary.City| 'Madurai' |
		 |Contact.PhoneNo| 569874632 |
		 |Contact.Email| "vipin's@gmail.com" | 	
		 
* print payloadNestedJson

@ignore
Scenario: create a simple json Object with variables
* def Name = 'vipin'
* def Age = 30
* def mail = "vipin's@gmail.com"
* set payloadSimpleJsonWithVariables
	 |path|value|
	 |name|Name|
	 |age|Age|
	 |email|mail| 
	 
* print payloadSimpleJsonWithVariables

@ignore
Scenario: create a simple Array Object - with value, with empty value, and with null value
* set payloadSimpleArrayOject

	 |path	|	0			|		1			|
	 |id		| 100		|	 101		|
	 |name	|'vipin'|'sainath'|
	 
* print payloadSimpleArrayOject

* set payloadSimpleArrayOjectEmptyValue
	
	 |path	|	0			|		1			|
	 |id		| 100		|	 				|		
	 |name	|'vipin'|'sainath'|
	 
* print payloadSimpleArrayOjectEmptyValue

* set payloadSimpleArrayOjectNullValue
	
	 |path	|	0			|		1			|
	 |id		| 100		|	(null)	|		
	 |name	|'vipin'|'sainath'|
	 
* print payloadSimpleArrayOjectNullValue


@ignore
Scenario: Manipulate Existing Json Object
* def existingJson = { name: 'sainath'}
* set existingJson

	 |path	|	value			|		
	 |id		| 100				|	
	 |name	|'vipin'		|
## Name value will be replaced -  sainath -> vipin 
* print existingJson

@ignore
Scenario: Manipulate Existing Json Object - set with json path
* def existingJson = { name: 'sainath'}
* set existingJson.details
	 |path	|	value			|		
	 |id		| 100				|	
	 |name	|'vipin'		|
## this id and name will be added as part of details object .. and name will not be replaced by vipin 
* print existingJson

@ignore
Scenario: Read the external Json file and append a new single object to it
* def existingJson = read('classpath:payload/createUser.json')
* set existingJson.contact
	 |path			|	value					|		
	 |doorNo		| 20						|	
	 |street		|'karate Street'	|
## this contact single object will be appended to the json file
* print existingJson


Scenario: Read the external Json file and append a new nested object to it
* def existingJson = read('classpath:payload/createUser.json')
* set existingJson.contact
	 |path							|	value						|		
	 |address.doorNo		| 20							|	
	 |address.street		|'karate Street'	|
## this contact nested object will be appended to the json file
* print existingJson