Feature: Request Headers API 


# Notes:   
# Headers, Header -> Keyword 
# Header = to set one specific header.
# Headers = to set multiple headers in a single step && used to pass a map object with all the list of headers
# configure = to set for global default header behavior


Background:
* def UserID = '8043318'
* def headersList = {Content-Type: 'text/xml;charset=ISO-8859-1', Connection: 'Keep-Alive', User-Agent: 'Mozilla/4.0(compatible;IE;GACv7\. 1\. 5192\. 22378)'}						
* def headersJson = 
    """
    {
      "Content-Type": "text/xml;charset=ISO-8859-1",
      "Accept": "application/json"
    }
    """							
							
Scenario: pass the user request with headers - static way

		# Header config 
    Given header Content-Type = 'text/xml;charset=ISO-8859-1'
    And header Accept-Encoding = 'gzip,deflate'
    And header Connection = 'Keep-Alive'
    And header Expect = '100-continue'
    And header User-Agent = 'Mozilla/4.0(compatible;IE;GACv7\. 1\. 5192\. 22378)'
    #And header Authorization = 'Bearer 007526d9efdbc07e084ff7a6d4cfcc90588fbe20641c00faebf45a7f'
    
    # Headers must be placed above the url - automatically it will get read 
    When url baseUrl + '/public/v1/users'
    And path '8043319'
    When method GET
    Then status 200
    * print response
    
  
Scenario: pass multiple request using map

		# Header config 
		* def req_header = {Content-Type: 'text/xml;charset=ISO-8859-1', Connection: 'Keep-Alive', User-Agent: 'Mozilla/4.0(compatible;IE;GACv7\. 1\. 5192\. 22378)'}
											
    # Headers must be placed above the url - here pass the req_header in headers
    Given headers req_header
    When url baseUrl + '/public/v1/users'
    And path UserID
    When method GET
    Then status 200
    * print response
    
    
Scenario: Globally apply headers to all request - from background 1 - map/dictionary
											
    # headersList - taken from backround 
    Given headers headersList
    When url baseUrl + '/public/v1/users'
    And path UserID
    When method GET
    Then status 200
    * print response

Scenario: Globally apply headers to all request - from background 2 - multi-line Json
						
		Given headers headersJson					
    # headersList - taken from backround 
    Given url baseUrl + '/public/v1/users'
    And path UserID
    When method GET
    Then status 200
    * print response
    
Scenario: Globally apply headers to all request - from config
	
		# No headers mentioned .. taken from karate-config.js file 
    Given url baseUrl + '/public/v1/users'
    And path UserID
    When method GET
    Then status 200
    * print response
    
Scenario: Globally apply headers to all request - from config - take token header from config
	
		# No headers mentioned .. taken from karate-config.js file 
    Given url baseUrl + '/public/v1/users'
    And path UserID
    When method GET
    Then status 200
    * print response
    
Scenario: pass the user request with headers - using configure keyword
	
		* configure headers = headersJson
		
    Given url baseUrl + '/public/v1/users'
    And path UserID
    When method GET
    Then status 200
    * print response
    

Scenario: User want to see the passed headers - Print the default Headers which passed
											
		* configure headers = headersJson
	  * configure afterScenario = function(){ karate.log('Sent headers:', karate.prevRequest.headers) }	
	  
    # headersList - taken from backround 
    Given url baseUrl + '/public/v1/users'
    And path UserID
    When method GET
    Then status 200
    * print response
		
		
## Note:
#   * configure headers = headersJson  - This line globally sets default HTTP headers for all HTTP requests
# 	configure headers = ... is a Karate built-in used to set headers globally.
#   You no longer need to write Given header ... for each request, because these headers are applied to every HTTP call automatically.

#   * configure afterScenario = function(){ karate.log('Sent headers:', karate.prevRequest.headers) }
#   This configures a JavaScript function to run after each scenario ends — it's a built-in Karate hook.
#   This line logs the actual HTTP headers used during the request, so you can confirm what was sent to the server
#   afterScenario is a Karate hook that's automatically called after every scenario in the .feature file.
#   karate.prevRequest gives you access to the last request made (useful for debugging).
#   karate.prevRequest.headers gives you the actual headers that were sent.