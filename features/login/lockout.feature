Feature: user gets locked out after N incorrect login attempts
	A user wants to be locked out after excessive failures 
	in order to ensure that their password can't be guessed.
	
	Scenario: user attempts to log in many times with the wrong password
	Given the username is "lockout@jemurai.com"
	When the password is "hi"
	Then the account should be locked out.