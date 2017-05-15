class Bill < ApplicationRecord
  belongs_to :publication

  before_save :reference_generator
  before_save :add_price

  require "i18n"
  require 'securerandom'

  validates :reference, uniqueness: true

  def reference_generator
    unless self.reference.present?
      self.reference = "#" + customer_ref + generate_reference_number
    else
      uniqueness_of_reference
    end
  end

  def customer_ref
    ref_1 = I18n.transliterate(self.publication.customer).gsub(/\W/, '')
    # I18n.transliterate removes all accents but keeps letters à => a
    ref_1.first(4).upcase
  end

  def generate_reference_number
    rand.to_s[4..7]
    #that generate a random number with 4 to 7 digits
  end

  def uniqueness_of_reference
    if self.reference == reference_generator
      generate_reference_number
    end
  end


  def add_price
    self.amount = 154.35
  end

end

