class BillsController < ApplicationController
  before_action :find_publication, only: :create


  def create
    @bill =  Bill.new(bill_params)
    reference = @bill.reference_generator
    if @bill.save
      #do something
    else
      #do something else
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:amount, :reference)
  end

  def find_publication
    @publication = Publication.find(params[:publication_id])
  end
end
