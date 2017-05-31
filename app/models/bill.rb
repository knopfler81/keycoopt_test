class Bill < ApplicationRecord
  belongs_to :publication

  before_save :check_if_reference_exists
  before_save :add_price

  require "i18n"
  require 'securerandom'

  validates :reference, uniqueness: true

  def add_price
    self.amount = 154.35
  end

  def check_if_reference_exists
    bill = Bill.where(reference: self.reference).first
    if bill != nil
      reference_generator
      #puts "It doesn't exist"
    else
      reference_generator
      #puts "It exists"
    end
  end


  def reference_generator
    self.reference = "#" + customer_ref + generate_reference_number
  end

  def customer_ref
    ref_1 = I18n.transliterate(self.publication.customer).gsub(/\W/, '')
    ref_1.first(4).upcase
    # I18n.transliterate removes all accents but keeps letters à => a
  end

  def generate_reference_number
    rand.to_s[4..7]
    #that generate a random number with 4 to 7 digits
  end

end

