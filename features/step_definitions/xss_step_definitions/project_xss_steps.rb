Given(/^the field is "(.*?)"$/) do |arg1|
  @field = arg1
end

When(/^the value is "(.*?)"$/) do |arg1|
  @value = arg1
end

Then(/^the field result should be "(.*?)"$/) do |arg1|
  @result = arg1
  
  login_as_user('mkonda@jemurai.com', 'password')
  uniq = Time.now.to_s
  new_project("XSS Name" + uniq, "XSS Desc"+ uniq)

  click_button "Edit"
  
  fill_in @field, :with => @value
  click_button "Update Project"
  
  if @result == "xss" 
    expect(page).to have_content @value
  else
    expect(page).to have_content ''
  end
  
end
