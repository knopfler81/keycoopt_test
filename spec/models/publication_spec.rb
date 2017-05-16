require 'rails_helper'

describe Publication  do
  it { should have_one(:bill)}
end


