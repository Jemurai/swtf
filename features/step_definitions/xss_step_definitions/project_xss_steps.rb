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
    # This should have xss in it...did it stick?
    alerted = false
    begin 
      page.driver.browser.switch_to.alert.accept   # For now assume any XSS has an alert.
      alerted = true
    rescue 
    end
    if alerted
      fail("XSS Used to create Popup in #{@field} with #{@value}")  
    else
      puts "Good news, no xss where expected."
    end
  else
    puts "No dialog..."
    expect(page).to have_content @value
  end
  
end
