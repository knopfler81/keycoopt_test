class Publication < ApplicationRecord
  after_create :send_alert_email
  has_one :bill

  validates :customer, uniqueness: {scope: :title}

  private

  def send_alert_email
    PublicationMailer.alert(self).deliver_now
  end

end
