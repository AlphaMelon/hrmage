require 'spec_helper'

feature "[Domain]" do
  background do
    create_organization_with_parameter("hrmagetest.dev", "HR Mage test") 
    create_organization_with_parameter("becontest.hrmage.dev", "becon test")
  end
  
  scenario "View Organization using domain" do
    visit "http://alphamelontest.hrmage.dev:#{Capybara.server_port}/?beta=1" 
    page.should have_content("AlphaMelon")
    
    visit "http://hrmagetest.dev:#{Capybara.server_port}/?beta=1" 
    page.should have_content("HR Mage test")
    
    visit "http://becontest.hrmage.dev:#{Capybara.server_port}/?beta=1" 
    page.should have_content("becon test")
  end
  
end
