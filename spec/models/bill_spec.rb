require 'rails_helper'

describe Bill  do
  it { should belong_to(:publication)}

  it { is_expected.to callback(:add_price).before(:save) }
  it { is_expected.to callback(:check_if_reference_exists).before(:save) }

  describe "#add_price" do

     it "add the amount to the bill" do
      publication= create(:publication)
      bill= create(:bill, publication: publication)

      bill.save

      expect(bill.add_price.to_f).to eq(154.35)
    end
  end

  describe "#customer_ref" do

    it "takes the 4 first letters of the customer's name and capitalize them" do

      publication= create(:publication, customer: "L'équipe")
      bill= create(:bill, publication: publication)

      bill.save

      expect(bill.customer_ref).to eq("LEQU")
    end
  end

end


