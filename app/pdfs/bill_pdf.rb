class BillPdf < Prawn::Document

  def initialize(bill)
    super(top_margin: 70)
    @bill = bill
    bill_number
    total_amount
  end


  def bill_number
    text "Facture #{@bill.reference}", size: 20
  end

  def total_amount
    text "\n
          Client #{@bill.publication.customer}\n
          Annonce: #{@bill.publication.title}\n
          Montant TTC de la Facure: #{@bill.amount} € \n"


  end

end
