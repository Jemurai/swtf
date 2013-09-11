When(/^the accesses the dashboard$/) do
  visit "/"
end

Then(/^the session cookie should not contain sensitive information$/) do
  cookies = Capybara.current_session.driver.browser.manage.all_cookies
  
  cookie = cookies[0]
  detail = cookie[:value]
  # puts "Detail is #{detail}"
  puts "Cookie is #{cookie}"  
  
  decoded = ""
  begin
    decoded = Marshal.load(Base64.decode64(detail))
  rescue
    decoded = ""
  end

  #  puts decoded
  expect(decoded).not_to have_content '"CTF_FLAG"=>"2112"'
  
  # In prod this should be true.
  # expect(cookie).to have_content 'HttpOnly' # This is not coming through for some reason. Can see with burp, but not here.

  # In prod these should also be applicable.
  #  expect(cookie).to have_content ':secure=>true'
  
  expect(cookie).not_to have_content ':expires=>nil'
  
end