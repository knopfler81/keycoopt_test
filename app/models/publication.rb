class Publication < ApplicationRecord
  after_create :alert
  has_one :bill

  validates :customer, uniqueness: {scope: :title}

 private

  def alert
    SendEmailToServiceJob.perform_later(id)
  end

end
