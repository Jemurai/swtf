Feature: person is restricted from accessing project they do not own
	In order to trust the system
	as a user 
	each person should only be able to access their projects
	
	Scenario: person creates a project
	Given a new project created by a user
	When a different person attempts to access the project
	Then the system should prevent access
	
	