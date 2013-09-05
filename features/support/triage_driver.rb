module TriageDriver
  
  def register_as_user(username, password)
    visit 'users/sign_up'
    fill_in "user[email]", :with => username
    fill_in "user[password]", :with => password
    fill_in "user[password_confirmation]", :with => password
    click_button "Create My Account"
  end
  
  def logout(username)
    click_link "Logout #{username}"
  end
  
  def login_as_user(username, password)
     visit '/users/sign_in'
     fill_in "user[email]", :with => username
     fill_in "user[password]", :with => password
     click_button "Sign in"  
  end

  def access_project(id)
    visit '/projects/' + id
  end

  def new_project(name, description = nil, priority = 3, rank = 3, tier = 3,verified = false, rich_description = nil)
     visit '/projects/'
#     if page.driver.browser.switch_to.alert
#       page.driver.browser.switch_to.alert.accept  
#     end
     click_button "New Project"
     fill_in "project[name]", :with => name if name
     fill_in "project[description]", :with => description if description
     fill_in "project[priority]", :with => priority if priority
     fill_in "project[rank]", :with => rank if rank
     fill_in "project[tier]", :with => tier if tier
     fill_in "project[verified]", :with => verified if verified
     fill_in "project[rich_description]", :with => rich_description if rich_description
     click_button "Create Project"
  end

end

World(TriageDriver)

