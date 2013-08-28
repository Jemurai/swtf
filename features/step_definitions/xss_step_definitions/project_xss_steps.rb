Given(/^the field is "(.*?)"$/) do |arg1|
  @field = arg1
end

When(/^the value is "(.*?)"$/) do |arg1|
  @value = arg1
end

Then(/^the field result should be "(.*?)"$/) do |arg1|
  @result = arg1
  uniq = Time.now.to_s
  run = SecureRandom.uuid
  user = "test+#{run}@jemurai.com"
  register_as_user(user, "password")
  logout(user)
  login_as_user(user, 'password')
  
  new_project("XSS Name #{@field} #{uniq}", "XSS Desc #{@field}"+ uniq)
  
  click_link 'Edit'
  
  fill_in @field, :with => @value
  click_button "Update Project"
  
  if @result == "xss" 
    puts "Accepting"
    page.driver.browser.switch_to.alert.accept  
#    expect(page).to have_content @value
    
  else
    puts "No dialog..."
    expect(page).to have_content @value
  end
  
end
