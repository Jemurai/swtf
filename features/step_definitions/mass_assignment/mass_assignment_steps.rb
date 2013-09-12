require 'net/http'
require 'uri'

When(/^the user sets verified to true$/) do
  click_link 'Edit'
  url = current_url
  cookies = Capybara.current_session.driver.browser.manage.all_cookies
  csrf_token = Capybara.current_session.driver.browser.find_element(:xpath, "//meta[@name='csrf-token']").attribute('content');
  
  cookie = cookies[0]
  detail = cookie[:value]
  url = url.gsub( /\/edit\z/, '')  # Post to root, not the /edit
  
  # Switch mode to net::http
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)  
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Post.new(uri.request_uri)
  request['Cookie'] = cookies 
  request['_triage_session'] = detail
  request.set_form_data( { 
      "project[verified]" => true,   # This is the problem right here.
      "_method" => "put", 
      "authenticity_token" => "#{csrf_token}", 
      "project[name]"=> "mass assigned", 
      "project[description]" => "mass assigned", 
      "project[priority]" => "2", 
      "project[tier]" => "3", 
      "project[rich_description]"=>"hi", 
      "commit"=>"Update Project" })
  @response = http.request(request)
end

Then(/^the update should not update verified$/) do
  case @response
    when Net::HTTPSuccess     then @response
    when Net::HTTPRedirection then 
      location = URI.parse(@response['location'])
      # puts "Location url: #{location}"
      @response = Net::HTTP::get_response(location)
    else
      puts "ERROR IN RESPONSE!"
      expect(@response.error!).to have_content '500' # response.error!
    end
  
  expect(@response).to have_content 'Sign Up' # An indication we have been logged out.    
end