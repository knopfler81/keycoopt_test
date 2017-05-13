class Publication < ApplicationRecord
  after_create :send_alert_email

  private

  def send_alert_email
    PublicationMailer.alert(self).deliver_now
  end

end
