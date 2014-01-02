require 'spec_helper'

feature "[Domain]" do
  background do
    #create_organization domain: "staff.alphamelon.dev", name: "AlphaMelon"
    #create_organization domain: "xyz.dev"
  end
  
  scenario "View Organization using domain" do
    visit "http://alphamelontest.hrmage.dev:#{Capybara.server_port}" 
    page.should have_content("AlphaMelon")
  end
  
end
