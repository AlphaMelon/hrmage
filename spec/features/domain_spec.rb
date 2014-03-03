require 'spec_helper'

feature "[Domain]" do
  background do
    create_organization_with_parameter("xyz test", "Malaysia","myr")
  end

  scenario "View Organization using domain" do
    
    visit "http://xyztest.hrmage.dev:#{Capybara.server_port}"
    page.should have_content("xyz test")
    current_url.should == "http://xyztest.hrmage.dev/accounts/sign_in"
    
    #test no domain found
    visit "http://nodomain.dev:#{Capybara.server_port}"
    current_url.should == "http://hrmage.dev/"
    
  end
  
end
