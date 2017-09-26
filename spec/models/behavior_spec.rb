require 'rails_helper'

RSpec.describe Behavior, type: :model do
  it 'has a valid factory' do
    expect(build(:behavior)).to be_valid
  end
end
