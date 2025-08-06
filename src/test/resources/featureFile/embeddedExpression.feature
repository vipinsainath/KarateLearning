Feature: usage of embedded expression for passing variable values

## Note:
# Syntax:   #(VariableName) 
# Embedded Expressions are mostly used to call variable name inside { } 
# embedded expression is mostly used for getting value from global variable,
# Ex: In karate-config file, we have baseUrl, to pass this variable value in any json object or any function, we can use this embedded exp


Scenario: Embedded Expression in karate 

* def FirstName = 'vipin'
* def LastName = 'sainath'

## Directly set the first Name with variable
* def jsonObject = { First Name: FirstName }
* print 'jsonObject: ', jsonObject

## set value through embedded expression
* def jsonObject2 = { First Name: #(FirstName), Last Name: #(LastName) }
* print 'jsonObject: ', jsonObject2

## set value through globally - taken baseUrl from the config file
* def jsonObject3 = { Base Url: #(baseUrl) }
* print 'jsonObject: ', jsonObject3

