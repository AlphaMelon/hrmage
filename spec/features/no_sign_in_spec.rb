require 'spec_helper'

feature "[Not Signed In]" do
  
  scenario "Home page" do
    visit root_path
    page.should have_content "Sign In"

  end 
  
end
