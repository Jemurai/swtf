require 'cucumber/formatter/unicode'

require 'capybara/cucumber'
require 'securerandom'


Capybara.default_driver = :selenium

Capybara.app_host = 'http://triage-secure:3000/'

#Capybara.app_host = 'http://triage-insecure:3000/'
