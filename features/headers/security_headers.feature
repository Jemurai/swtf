Feature: user is protected from malicious content and having their page framed
	A user wants to be sure that effective browser protections are enabled 
	in order to ensure that their information is safe.
	
	@javascript
	Scenario Outline:  check for secure headers attempt
		Given a new project created by a user
		And the page is "<page>"
		When the header is "<header>"
		Then the header value should be "<result>"
		
		Scenarios: headers in pages
			| page | header | result |
			| projects/  | X-Frame-Options | DENY |
			| projects/  | X-XSS-Protection | 1 |
