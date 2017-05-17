class Bill < ApplicationRecord
  belongs_to :publication

  before_save :unique_refference #:reference_generator
  before_save :add_price

  require "i18n"
  require 'securerandom'

  validates :reference, uniqueness: true


  def add_price
    self.amount = 154.35
  end

  def unique_refference
    if send(:read_attribute, :reference) == self.reference
      reference_generator
    else
      reference_generator
    end
  end

  def customer_ref
    ref_1 = I18n.transliterate(self.publication.customer).gsub(/\W/, '')
    ref_1.first(4).upcase
    # I18n.transliterate removes all accents but keeps letters à => a
  end

  def reference_generator
    self.reference = "#" + customer_ref + generate_reference_number
  end


  def generate_reference_number
    rand.to_s[4..7]
    #that generate a random number with 4 to 7 digits
  end

end

