class BillsController < ApplicationController

  def show
    @bill = Bill.find(params[:id])
    respond_to  do |format|
      format.html
      format.pdf do
        pdf = BillPdf.new(@bill)
        send_data pdf.render, filename: "facture_#{@bill.reference}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
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
