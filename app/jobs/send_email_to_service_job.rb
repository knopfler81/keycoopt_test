class SendEmailToServiceJob < ApplicationJob
  queue_as :default

  def perform(publication_id)
    publication = Publication.find(publication_id)
    PublicationMailer.alert(publication).deliver_now
  end

end
