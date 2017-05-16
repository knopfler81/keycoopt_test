require "rails_helper"

feature "An authenticated user can access to the protected interface" do
  include_context 'When authenticated'

  scenario "visits publications page" do

    visit publications_path

    expect(page).to have_content("Annonces publiées")
  end

  scenario "generate an invoice" do
    publication= create(:publication, customer: "L'équipe")

    visit publications_path
    find('.publication-reference').first(:link, "Générer").click
  end


end

