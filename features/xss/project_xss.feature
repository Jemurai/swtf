Feature: user is prevented from putting XSS in project form fields
	A user wants to be sure that others users can't put XSS in the projects pages
	in order to ensure that their sessions and information are safe.
	
	@javascript
	Scenario Outline:  xss attempt
		Given the field is "<fieldname>"
		When the value is "<value>"
		Then the field result should be "<result>"
		
		Scenarios: no username
			| fieldname | value | result |
			| project[name]   | <script>alert('project[name]->xss');</script>   | xss    |
			
			