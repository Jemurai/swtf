require 'net/http'
require 'uri'


Given(/^the page is "(.*?)"$/) do |arg1|
  @page = arg1
end

When(/^the header is "(.*?)"$/) do |arg1|
  @header = arg1
  @header = @header.downcase if @header
end

Then(/^the header value should be "(.*?)"$/) do |arg1|
  # Selenium doesn't itself get the headers so blend the approach.
  @result = arg1
  uniq = Time.now.to_s
  run = SecureRandom.uuid
  user = "test+#{run}@jemurai.com"
  register_as_user(user, "password")
  visit @page  
  url = current_url
  cookies = Capybara.current_session.driver.browser.manage.all_cookies
  
  # Switch mode to net::http
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)  
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(uri.request_uri)
  request['Cookie'] = cookies 
  response = http.request(request)
  #  puts "Response for #{@header} is #{response[@header]}"
  if response[@header] == @result
    #pass
  else
    fail("Header #{@header} not set to #{@result} as expected.")
  end
end