Feature: Generate Random Values for payload using DataFaker 

## Notes:
# Datafaker is a maven dependency, import it
# Either way we can use it,  1 --> directly importing/ integrating it into feature file
#														 2 --> Create a java class, import the data faker class, create a functions for generating random values
#																	  and we can call those functions in the feature file.

# To import any class into feature file, use the below syntax:
#  * def var = java.type(" here give the package path")
#  * def obj = new var()	- create an object for the class 'var'
#  * def abc = obj.xxx()  - with this obj we can call the functions


## Way 1 - directly importing/ integrating dataFaker into feature file
Scenario: Generate Random values using data faker - directly importing data faker in feature file

# Import the package of dataFaker
* def dataFaker = Java.type("net.datafaker.Faker")
* def dataFakerObj = new dataFaker()

* def idValue = dataFakerObj.number().digits(5)
* def nameValue = dataFakerObj.name().fullName()

* set createSimpleJson 
	|path| value 			|
	|id  | idValue		|
	|name| nameValue	|
	
* print createSimpleJson





## Way 2 - calling dataFaker java class into feature file
Scenario: Generate Random values using data faker - directly importing data faker in feature file

# Import the java class 
* def dataFaker = Java.type('Utils.randomDataFaker') 		

* def idValue = dataFaker.generateRandomID(5)
* def nameValue = dataFaker.generateRandomName()

* set createSimpleJson 
	|path| value 			|
	|id  | idValue		|
	|name| nameValue	|
	
* print createSimpleJson