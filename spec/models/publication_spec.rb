require 'rails_helper'

describe Publication  do
  it { should have_one(:bill)}
  it { should validate_uniqueness_of(:customer).scoped_to(:title) }
  it { is_expected.to callback(:alert).after(:create) }


end


