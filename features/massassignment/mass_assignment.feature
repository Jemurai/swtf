Feature: user should not be able to set fields not shown in the form
	A user wants to see that requests setting fields that are not 
	available in a form will not be set 
	in order to ensure that users can only edit data they should be able to access.
	
	Scenario: user attempts to verify a project although it is not in the form
	Given a new project created by a user
	When the user sets verified to true
	Then the update should not update verified