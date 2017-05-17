require 'rails_helper'


describe BillsController do

  include AuthHelper
  before(:each) do
    http_login
  end

  context "GET show/:id" do

    it "should show bill" do
      publication= create(:publication)
      bill= create(:bill, publication: publication)
      get :show, id: bill.id
    end

  end

  context "POST #create" do

    it "creates new bill" do
      publication= create(:publication)
      bill= create(:bill, publication: publication)
      expect(Bill.count).to eq(1)
    end
  end

end
