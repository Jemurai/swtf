require 'net/http'
require 'uri'

Given(/^the page is "(.*?)"$/) do |arg1|
  @page = arg1
end

When(/^the header is "(.*?)"$/) do |arg1|
  @header = arg1
  # @header = @header.downcase if @header
end

Then(/^the header value should be "(.*?)"$/) do |arg1|
  # Selenium doesn't itself get the headers so blend the approach.
  @result = arg1
  url = current_url
  cookies = Capybara.current_session.driver.browser.manage.all_cookies
  csrf_token = Capybara.current_session.driver.browser.find_element(:xpath, "//meta[@name='csrf-token']").attribute('content');
  
  # Switch mode to net::http
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)  
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Post.new(uri.request_uri)
  request['Cookie'] = cookies 
  request.set_form_data( { 
      "project[verified]" => true,   # This is the problem right here.
      "_method" => "put", 
      "authenticity_token" => "#{csrf_token}", 
      "project[name]"=> "header updated and verified", 
      "project[description]" => "header updated and verified", 
      "project[priority]" => "2", 
      "project[tier]" => "3", 
      "project[rich_description]"=>"hi", 
      "commit"=>"Update Project" })
  response = http.request(request)
  
  case response
    when Net::HTTPSuccess     then response
    when Net::HTTPRedirection then 
      location = URI.parse(response['location'])
      response = Net::HTTP.get_response(location)
    else
      response.error!
    end
  if response[@header] == @result
    #pass
  else
    fail("Header #{@header} not set to #{@result} as expected.  Instead was #{response[@header]}.")
  end
end