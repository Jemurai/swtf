# SWTF 

SWTF stands for security web testing framework.  SWTF is built upon Cucumber and RSpec to define example security tests in business domain language with specific working tests that illustrate how to test for real security issues.

## Notice of Retirement

This repository has been archived and is no longer actively maintained.

## Intended Usage

One goal for SWTF is to provide examples of how to test for common security issues, including the OWASP Top 10 and other significant security issues in Rails.

### Running

bundle install  
cucumber

### Details about Features

Current coverage includes:  

* Injection / Sql Injection
* Cross Site Scripting
* Mass Assignment
* Cross Site Request Forgery
* Secure Headers
* Sensitive Data Exposure (Session Cookie)

In progress:   

* Login - Test 

## Triage

The tests are written to run against Triage (https://github.com/Jemurai/triage).  If you run that the tests should work against it.

## License
SWTF is licensed under MIT (http://opensource.org/licenses/mit-license.php)
