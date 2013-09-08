Feature: person is restricted from putting input into a field that will be executed by the system
	In order to trust the system
	as a user 
	no user should be able to submit code that the software runs
	
	Scenario: attacker attempts to inject a command in form input
	Given a new project created by a user for injection
	When the user puts shell code in the form field
	Then the system should prevent arbitrary execution
