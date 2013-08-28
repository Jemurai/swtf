module TriageDriver
  
  def login_as_user(username, password)
     visit 'http://localhost:3000/users/sign_in'
     fill_in "Email", :with => username
     fill_in "Password", :with => password
     click_button "Sign in"  
  end

  def access_project(id)
    visit 'http://localhost:3000/projects/' + id
  end

  def new_project(name, description = nil, priority = 3, rank = 3, tier = 3,verified = false, rich_description = nil)
     visit 'http://localhost:3000/projects/'
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