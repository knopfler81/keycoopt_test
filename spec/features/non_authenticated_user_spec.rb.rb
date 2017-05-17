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

  scenario "see the generated invoice" do
    publication= create(:publication, customer: "L'équipe")
    bill = create(:bill, amount: 154.35, publication: publication)

    visit bill_path(bill)
    expect(page).to have_content("Facture ref:")
  end

  scenario "once on the invoice, go back to the publications list" do
    publication= create(:publication, customer: "L'équipe")
    bill = create(:bill, amount: 154.35, publication: publication)

    visit bill_path(bill)
    click_link("Retour à la liste")

    expect(page).to have_content("Annonces publiées")
  end

  scenario "download the invoice as a pdf" do
    publication= create(:publication, customer: "L'équipe")
    bill = create(:bill, amount: 154.35, publication: publication)

    visit bill_path(bill)
    click_link("Télécharger le pdf")

    expect(page.response_headers['Content-Type']).to eq("application/pdf")
  end

end

