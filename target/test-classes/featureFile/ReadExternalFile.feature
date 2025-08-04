Feature: read and write external file


Background:


@ignore
Scenario: Read and Write a JSON file 
# read a file and store in variable
* def payloadFile = read('classpath:payload/createUser.json')

# print the data 
* print 'Printing the actual external JSON file: ', payloadFile

# Edit/ Update the Email value, for that we use set keyword
* set payloadFile.name = 'vipinsainath'
* set payloadFile.email = 'vipin' + java.util.UUID.randomUUID() + '@gmail.com' 	

# print the update the data
* print 'Printing the Updated external JSON file: ', payloadFile

@ignore
Scenario: Read and Write a JS file
# read a file and store in variable
* def JSFile = read('classpath:payload/createUser2.js')
# Call the function to get the payload
* def payloadJS = JSFile()
# print the data 
* print 'Printing the actual external JS file: ', payloadJS

# Edit/ Update the Email value, for that we use set keyword
* set payloadJS.name = 'vipin sainath'
* set payloadJS.email = 'vipin' + java.util.UUID.randomUUID() + '@gmail.com' 	
# print the update the data
* print 'Printing the Updated external JS file: ', payloadJS

@ignore
Scenario: Remove a key-value from a JSON file
# read a file and store in variable
* def payloadFile = read('classpath:payload/createUser.json')
# print the data 
* print 'Printing the actual external JSON file: ', payloadFile

# Remove 'gender' from the json file, we use remove keyword
* remove payloadFile.gender

# print the update the data
* print 'Printing the Updated external JSON file: ', payloadFile


@ignore
Scenario: Add a new attribute into JSON File
# read a file and store in variable
* def payloadFile = read('classpath:payload/createUser.json')

# print the data 
* print 'Printing the actual external JSON file: ', payloadFile

# Add Address key-value into json, for that we use set keyword - first it will check for the address already exist or not. if not, it will add it
* set payloadFile.address = '123, testStreet'

# print the update the data
* print 'Printing the Updated external JSON file: ', payloadFile
* print 'added address key and value to the existing json file' 

@ignore
Scenario: Add json into another JSON File
# read a file and store in variable
* def payloadFile = read('classpath:payload/createUser.json')

# print the data 
* print 'Printing the actual external JSON file: ', payloadFile

# Add multiline key-value into json, for that we use set keyword - first it will check for the attribute already exist or not. if not, it will add it
* set payloadFile.address = 
"""
{
  "AddressLine1": {
    "DoorNo": 12,
    "Street": "testStreet",
    "Pincode": 6541235
  },
  "Contact": {
    "phone": 1234567890,
    "email": "karate@gmail.com"
  }
}
"""

# print the update the data
* print 'Printing the Updated external JSON file: ', payloadFile
* print 'added address key and value to the existing json file' 




Scenario: Add a multi line attribute list into JSON File
# read a file and store in variable
* def payloadFile = read('classpath:payload/createUser.json')
* def addressContactpayloadFile = read('classpath:payload/addressAndContact.json')

# print the data 
* print 'Printing the actual external JSON file: ', payloadFile

# Add multiline key-value into json, for that we use set keyword - first it will check for the attribute already exist or not. if not, it will add it
* set payloadFile.address = addressContactpayloadFile

# print the update the data
* print 'Printing the Updated external JSON file: ', payloadFile
* print 'added address Json to the existing json file' 