When(/^the accesses the dashboard$/) do
  visit "/"
end

Then(/^the session cookie should not contain sensitive information$/) do
  cookies = Capybara.current_session.driver.browser.manage.all_cookies
  
  cookie = cookies[0]
  detail = cookie[:value]
  # puts detail
  
  decoded = Marshal.load(Base64.decode64(detail))
  #  puts decoded
  expect(decoded).not_to have_content '"CTF_FLAG"=>"2112"'
end