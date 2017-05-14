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
          Nom du client: #{@bill.publication.customer}\n
          Titre de l'annonce: #{@bill.publication.title}\n
          Date de publication de l'annonce: #{@bill.publication.created_at.strftime("%d/%m/%Y")}\n
          Date de facturation: #{@bill.created_at.strftime("%d/%m/%Y")}\n
          Montant: #{@bill.amount} € \n"
  end

end
