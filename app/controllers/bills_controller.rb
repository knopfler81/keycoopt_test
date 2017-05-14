class BillsController < ApplicationController

  def show
    @bill = Bill.find(params[:id])
  end

  def create
    @bill =  Bill.create(publication_id: params[:publication_id])
    if @bill.save
      redirect_to bill_path(@bill), notice: "La facture a bien été générée"
    else
      redirect_to pubications_path, alerte: "La facture n'a pas été générée"
    end
  end

end
