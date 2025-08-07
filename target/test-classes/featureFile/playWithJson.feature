Feature:  Operations performed with JSON Object

#Taken externally "CreateUser.json"
## Note:
# Many Ways to fetch Data
# Way 1 - directly by json object 			---  jsonObject.att
# Way 2 - using get keyword 						---  get jsonObject.att
# Way 3 - using $ keyword 							---  $jsonObject.att
# Way 4 - using get function 		  			---  karate.get('$jsonObject.att')
#																				---  karate.get('$jsonObject.att1.att2[*].att3')[n]  <--- passing * and index
# Way 5 - using jsonPath function 		  ---  karate.jsonPath(jsonObject, '$.att')
#																				---  karate.jsonPath(jsonObject, '$..att')  <--- $.. deep scan for the attribute at any level within the jsonObject 
																				
## Note: $ represent entire json
## 			 * represents all 
##			 $.. deep scan for the attribute at any level within the jsonObject 

## JsonPath filter expressions --> ([?(@.someField == 'value')]) always return an array, even if only one item matches.
## Using this we can pass the conditions
## conditions syntax can be applied only to jsonPath() function .. will not work for get() function
## We can use operands like  -  &&, || 



Scenario: Read and Print the json 
* def jsonObject = read('classpath:payload/createUser.json')
## Print json 
* print 'Create User JSON Object: ', jsonObject


@ignore
Scenario: Extract Value from json object and verify
* def jsonObject = read('classpath:payload/createUser.json')

## Way 1
* def name = jsonObject.name
* print 'name: ', name
# validation
* match name == 'vipin'

## Way 2 - using get keyword - get + jsonObject
* def email = get jsonObject.email
* print 'email: ', email
# validation
* match email == 'vipin123@example.com'

## Way 3 - using get and $ keyword  - get + jsonObject + $
* def gender = get jsonObject $.gender
* print 'gender: ', gender
# validation
* match gender == 'male'

## Way 4 - using only $ keyword
* def status = $jsonObject.status
* print 'status: ', status
# validation
* match status == 'active'

## Way 5 - using karate get function
* def name2 = karate.get('$jsonObject.name')
* print 'name2: ', name2
# validation
* match name2 == 'vipin'

## Way 6 - using karate jsonPath function - takes 2 parameters, (jsonFileName, attribute)
* def email2 = karate.jsonPath(jsonObject, '$.email')
* print 'email2: ', email2
# validation
* match email2 == 'vipin123@example.com'


@ignore
Scenario: Extract value from nested json and verify
* def jsonObjectBookStore = read('classpath:payload/bookStore.json')

* print 'Book Store: ',jsonObjectBookStore 

# Way 1 - print one book title
* def Book2Title = jsonObjectBookStore.store.book[1].title     
* print 'Title of Book 2: ', Book2Title

# Way 2 - print the titles of all the books - we can use get function and *  --->  get + $ + * 
## * def AllBookTitles = jsonObjectBookStore.store.book[*].title    --> this will not work
* def AllBookTitles = karate.get('$jsonObjectBookStore.store.book[*].title')
* print 'printing all book titles: ', AllBookTitles


# Way 3 - fetch all book title and print only 3rd book
* def Book3Title = karate.get('$jsonObjectBookStore.store.book[*].title')[3]
* print 'Title of Book 3: ', Book3Title

# Way 4 - print the titles of all the books - we can use jsonPath function 		--> 	$..
* def AllBookTitle = karate.jsonPath(jsonObjectBookStore, '$..title')
* print 'printing all book titles: ', AllBookTitle




@ignore
Scenario: Extract value from json with Condition using Json Path Filtering 
* def jsonObjectBookStore = read('classpath:payload/bookStore.json')
* print 'Book Store: ',jsonObjectBookStore 

## Apply condition on fetching value from json

# Json path filter - fetch book full details and also title whose authore name is 'Nigel Rees' 
* def authorNigelRees = karate.jsonPath(jsonObjectBookStore, "$.store.book[?(@.author=='Nigel Rees')]")
* print "printing Nigel Rees's book details : ", authorNigelRees

* def authorNigelReesBookTitle = karate.jsonPath(jsonObjectBookStore, "$.store.book[?(@.author=='Nigel Rees')].title")
* print "printing Nigel Rees's book title : ", authorNigelReesBookTitle

## we can use operands ( &&  and  ||  )
## Using && - filter by author and category
* def authorEvelynWaugh = karate.jsonPath(jsonObjectBookStore, "$.store.book[?(@.author=='Evelyn Waugh' && @.category=='fiction')]")
* print "printing Evelyn Waugh's book details : ", authorEvelynWaugh


## Using || - filter by authors 
* def authors = karate.jsonPath(jsonObjectBookStore, "$.store.book[?(@.author=='Evelyn Waugh' || @.author=='Nigel Rees')]")
* print "printing book details : ", authors





Scenario: Json Path function - indexing, and applying aggregators  
* def jsonObjectBookStore = read('classpath:payload/bookStore.json')
* print 'Book Store: ',jsonObjectBookStore 

## Fetch 0 to 3 index books from the list 
* def listOfBooks = karate.jsonPath(jsonObjectBookStore, '$.store.book[0:3]')
* print 'listing the first 4 books: ', listOfBooks


## Find how many books are there ?
* def howManyBooks = karate.jsonPath(jsonObjectBookStore, '$.store.book.length()')
* print 'How many books are there? ', howManyBooks


## Give me a list of all the prices of books
* def priceList = karate.jsonPath(jsonObjectBookStore, '$.store.book[*].price')
* print 'list of price of all books? ', priceList

## Give me the sum of the prices of all books
* def Totalprice = karate.jsonPath(jsonObjectBookStore, '$..price.sum()')		
* print 'sum of prices of all books? ', Totalprice


## What is the maximum price and minimum price of books
* def MaxPrice = karate.jsonPath(jsonObjectBookStore, '$..price.max()')	
* def MinPrice = karate.jsonPath(jsonObjectBookStore, '$..price.min()')			
* print 'Maximim price? ', MaxPrice
* print 'Minimum price? ', MinPrice



#############   Writing Operation   ######################

Scenario: Add json object into JSON File
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



Scenario: Append one json into another JSON File
# read a file and store in variable
* def payloadFile = read('classpath:payload/createUser.json')
* def appendPayloadFile = read('classpath:payload/addressAndContact.json')

# print the data 
* print 'Printing the actual external JSON file: ', payloadFile

# Add multiline key-value into json, for that we use set keyword - first it will check for the attribute already exist or not. if not, it will add it
* set payloadFile.address = appendPayloadFile

# print the update the data
* print 'Printing the Updated external JSON file: ', payloadFile
* print 'added address Json to the existing json file' 












