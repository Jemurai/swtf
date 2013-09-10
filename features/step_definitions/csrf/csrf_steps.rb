When(/^the user sets verified to true but does not update the CSRF token$/) do

  puts current_url

  url = current_url
  cookies = Capybara.current_session.driver.browser.manage.all_cookies
  
  # Switch mode to net::http
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)  
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Post.new(uri.request_uri)
  request['Cookie'] = cookies 
  request.set_form_data( { 
      "project[verified]" => true, 
      "_method" => "put", 
      "authenticity_token" => "Yztc%2FC5AnlbiJW8XWqb5mhJrA9TB%2BkzYTJ7EsDu1hRc%3D", # THIS IS THE WRONG TOKEN!!!
      "project[name]"=> "csrf attempt", 
      "project[description]" => "csrf attempt", 
      "project[priority]" => "2", 
      "project[tier]" => "3", 
      "project[rich_description]"=>"hi", 
      "commit"=>"Update Project" })
  response = http.request(request)
  @mass_assignment_response = response.body
end
