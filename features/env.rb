require 'cucumber/formatter/unicode'

require 'capybara/cucumber'

Capybara.default_driver = :selenium
Capybara.app_host = 'http://localhost:3000/'