Feature: Data-Driven 



## Standard Way
@ignore
Scenario Outline: Basic details of <Emp_Name>

## case 1
* def name = "<Emp_Name>"
* def id = <Emp_ID>
* def isActiveEmployee = <Emp_Status>
* print 'name: ', name
* print 'ID: ', id
* print 'Is Employee Active ? ', isActiveEmployee
## Validate Data Type
* match name == '#string'
* match id == '#number'
* match isActiveEmployee == '#boolean'


## Case 2 - converting number and boolean to string - how ? we can use "" or ''
* def empName = "<Emp_Name>"
* def empID = "<Emp_ID>"
* def empStatus = '<Emp_Status>'
## Validate Data Type
* match empName == '#string'
* match empID == '#string'
* match empStatus == '#string'


Examples:
|Emp_Name|Emp_ID|Emp_Status|
|vipin|100|true
|sainath|101|false|
|swetha|102|true|


## Way 1
@ignore
Scenario Outline: <Title> Book details and ingest data into json 
* def bookJson = 
"""
{
	"category": '<Category>',
  "author": '<Author>',
  "title": '<Title>',
  "price": <Price>
}
"""
* print 'Updated Book Store: ', bookJson
Examples:
|Category	|Author	|Title				|Price|
|romance	|vipin	|romeo Juliet	|19.50|
|Mystery  |swetha |One Hand 		|25.00|




## Way 2 - using embedded expression - useful when data having empty values
@ignore
Scenario Outline: <Title> Book details and ingest data into json using embedded expression
* def bookJson = 
"""
{
	"category": ##(Category),
  "author": ##(Author),
  "title": ##(Title),
  "price": ##(Price)
}
"""
* print 'Updated Book Store: ', bookJson

## Note: ## expression will omit the attribute if having null or empty values
Examples:
|Category	|Author	|Title				|Price|
|romance	|vipin	|romeo Juliet	|19.50|
|Mystery  |swetha |One Hand 		|			|
|Suspence |velu		|							|12.00|
