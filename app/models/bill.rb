class Bill < ApplicationRecord
  belongs_to :publication


  require "i18n"
  require 'securerandom'

  def reference_generator

    #ref keep only four letters and upcase
    ref_1 = self.publication.customer.first(4).upcase

    #remove space and accents
    ref_2 = ref_1.gsub(' ', '')
    ref_3 =  I18n.transliterate(ref_2)

    #add 4 or more digit
    unique_id = SecureRandom.random_number(9999)
    final_ref = ref_3 + unique_id.to_s

  end
end
