require 'spec_helper'

feature "[Domain]" do
  background do
    create_organization_with_parameter("xyz.dev", "xyz test", "myr")
  end

  scenario "View Organization using domain" do
    
    visit "http://xyz.dev:#{Capybara.server_port}/?beta=1"
    page.should have_content("xyz test")
    
    visit "http://staff.alphamelon.dev:#{Capybara.server_port}/?beta=1" 
    page.should have_content("AlphaMelon")
    
    #test no domain found
    visit "http://nodomain.dev:#{Capybara.server_port}/?beta=1"
    current_url.should == "http://hrmage.dev/"
    

  end
  
end
