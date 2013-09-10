When(/^the user sets verified to true$/) do
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
      "project[name]"=> "mass assigned", 
      "project[description]" => "mass assigned", 
      "project[priority]" => "2", 
      "project[tier]" => "3", 
      "project[rich_description]"=>"hi", 
      "commit"=>"Update Project" })
  response = http.request(request)
  @mass_assignment_response = response.body
end

Then(/^the update should not update verified$/) do
  puts @mass_assignment_response
  expect(@mass_assignment_response).to have_content 'false'
end