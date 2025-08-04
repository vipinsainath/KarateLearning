Feature: test
	
Background:

	
Scenario: test 1 
	* def name = 'vipin'
  * def result = { actualName: name }
  * return result


Scenario: test 2
	* def data = call read('classpath:featureFile/variable.feature')
  * print 'Got from helper:', data.actualName
