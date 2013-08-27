Feature: person registers for application
	In order to use the application
	as a user 
	each person needs to register
	
	Scenario: person registers for application
	Given a person named "Makoto"
	When person registers
	Then system should create a user
	
#Feature: user forgets user name
	
#Feature: person cannot access site without user