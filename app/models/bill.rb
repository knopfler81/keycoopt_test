class Bill < ApplicationRecord
  belongs_to :publication

  #before_save :check_if_reference_exists?

  before_save :add_price
  before_save :reference_generator

  require "i18n"
  require 'securerandom'

  def add_price
    self.amount = 154.35
  end

  def reference_generator
    existing_reference =  Bill.where(reference: self.reference).first
    if self.reference == existing_reference
      self.reference = "#" + customer_ref + generate_reference_number
    else
      #execute again if already exist
      self.reference = "#" + customer_ref + generate_reference_number
    end
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

  # def check_if_reference_exists?
  #   bill = Bill.where(reference: self.reference).first
  #   if bill.present?
  #     true
  #   else
  #     false
  #   end
  # end
end

