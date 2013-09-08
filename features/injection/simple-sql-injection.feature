Feature: person is restricted from putting input into a url that will be concatenated into a query
	In order to trust the system
	as a user 
	no user should be able to control the queries the software runs
	
	Scenario: attacker attempts to control query through restful uri string
	Given a new project created by a user
	When the user alters the location in browser to attempt sqli
	Then the system should display no projects
	
