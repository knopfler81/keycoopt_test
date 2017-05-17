require 'rails_helper'


describe PublicationsController do

  include AuthHelper
  before(:each) do
    http_login
  end

  describe "GET #index" do

    it "populates an array of publications" do
      publication = FactoryGirl.create(:publication)
      get :index
      expect(assigns(:publications)).to eq([publication])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end

  end

  describe "POST #create" do
    it "creates bill" do
      publication =  FactoryGirl.create(:publication)
      expect(response).to be_success
    end
  end



end
