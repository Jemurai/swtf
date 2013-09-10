Feature: users favorite album is in cookie
	A user wants to see that cookies do not contain sensitive information
	in order to ensure that their data is safe.
	
	Scenario: user accesses the application and sensitive data is in cookie
	Given a new project created by a user
	When the accesses the dashboard
	Then the session cookie should not contain sensitive information
	