require 'rails_helper'


describe Bill  do
  it { should belong_to(:publication)}

  it { is_expected.to callback(:add_price).before(:save) }
  it { is_expected.to callback(:reference_generator).before(:save) }

  describe "#add_price" do

     it "add the amount to the bill" do
      publication= create(:publication)
      bill= create(:bill, publication: publication)

      expect(bill.add_price.to_f).to eq(154.35)
    end
  end

  describe "#customer_ref" do

    it "takes the 4 first letters of the customer's name and capitalize them" do

      publication= create(:publication, customer: "L'équipe")
      bill= create(:bill, publication: publication)

      expect(bill.customer_ref).to eq("LEQU")
    end
  end

  describe "#reference_generator" do

    it "generate a unique reference" do
      publication = create(:publication, customer: "L'équipe")
      bill = build(:bill, publication: publication)
      bill.expects(:generate_reference_number).once.returns("0987")

      expect(bill.reference_generator).to eq("#LEQU0987")
    end

    it "generate another reference if it's already taken" do
      publication = create(:publication, customer: "L'équipe")
      previous_bill = create(:bill, publication: publication, reference: "#LEQU3467")
      bill = build(:bill, publication: publication, reference: "#LEQU3467")

      expect(bill.reference_generator).not_to eq("#LEQU3467")
    end
  end

  # describe "#check_if_reference_exists?" do

  #   it "return true if the reference exists" do
  #     publication = create(:publication, customer: "L'équipe")
  #     previous_bill = create(:bill, publication: publication, reference: "#LEQU3467")
  #     bill = build(:bill, publication: publication, reference: "#LEQU3467")

  #     result = bill.check_if_reference_exists?

  #     expect(result).to eq(true)
  #   end

  #   it "return false if the reference doesn't exist" do
  #     publication = create(:publication, customer: "L'équipe")
  #     bill = build(:bill, publication: publication, reference: "#LEQU3467")

  #     result = bill.check_if_reference_exists?

  #     expect(result).to eq(false)
  #   end
  # end
end


