class PublicationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.publication_mailer.alert.subject
  #
  def alert(publication)
    @publication = publication
    mail  to: "facturation@keycoopt.com",
          subject: "Nouvelle publication"
  end

end
