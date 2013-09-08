Feature: user logs in
	A user wants to log in 
	in order to use the system.
	
	@javascript
	Scenario Outline:  login attempt
		Given the username is "<username>"
		When the password is "<password>"
		Then the result should be "<succeeded>"
		
		Scenarios: no username
			| username | password | succeeded |
			| 		   | hello    | fail      | 
			
		Scenarios: no password
			| username | password | succeeded |
			|   matt   | 		  | fail      | 
			
		Scenarios: no username or password
			| username | password | succeeded |
			| 		   | 		  | fail      | 
		
		Scenarios: wrong password
			| username | password | succeeded |
			| matt     | hello    | fail      | 
		
		Scenarios: correct password
			| username | password | succeeded |
			| matt | password  | succeed      | 
		
