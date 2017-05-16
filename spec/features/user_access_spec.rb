require "rails_helper"

feature "A non authenticated visitor can access the landing page" do

  scenario "arrives on landing page" do
    visit root_path
    expect(page).to have_content("CONSULTER LES PUBLICATIONS")
  end

  scenario "wants to access to publications" do
    visit publications_path
    expect(page).to have_content("Access denied")
  end

end

