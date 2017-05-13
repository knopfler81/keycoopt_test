class PublicationMailerPreview < ActionMailer::Preview
  def alert
    publication = Publication.first
    PublicationMailer.alert(publication)
  end
end
