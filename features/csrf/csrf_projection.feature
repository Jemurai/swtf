Feature: user should not be able to submit forms in anothers session
	A user wants to see that requests for forms for other users do not work
	in order to ensure that users can only edit data they should be able to access.
	
	Scenario: user attempts csrf against another user
	Given a new project created by a user
	When the user sets verified to true but does not update the CSRF token
	Then the update should not update verified