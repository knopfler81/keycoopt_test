class Publication < ApplicationRecord

  after_create :alert

  has_one :bill

  validates :customer, uniqueness: {scope: :title}

  paginates_per 10

 private

  def alert
    SendEmailToServiceJob.perform_later(id)
  end

end
