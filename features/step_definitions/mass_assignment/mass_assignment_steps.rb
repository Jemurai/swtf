require 'net/http'
require 'uri'

When(/^the user sets verified to true$/) do
  click_link 'Edit'
  url = current_url
  puts "URL in mass assignment is #{url}"
  cookies = Capybara.current_session.driver.browser.manage.all_cookies
  csrf_token = Capybara.current_session.driver.browser.find_element(:xpath, "//meta[@name='csrf-token']").attribute('content');
  puts "CSRF Token #{csrf_token}"
  
  cookie = cookies[0]
  detail = cookie[:value]
  puts "Detail is #{detail}"
  puts "Cookie is #{cookie}"  
  
  
  # Post to root, not the /edit
  url = url.gsub( /\/edit\z/, '')
  puts url
  
#  "authenticity_token"=>"96TtH4tLvYbfn/MqLtaMi5w3yzRVYCgjD2hTwldI9i4="
  #            CSRF Token 96TtH4tLvYbfn/MqLtaMi5w3yzRVYCgjD2hTwldI9i4=
  
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
      
  puts request
  
  @response = http.request(request)
  
end

Then(/^the update should not update verified$/) do

  puts @response.body

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