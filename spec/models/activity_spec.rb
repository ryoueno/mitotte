require 'rails_helper'

RSpec.describe Activity, type: :model do
  it 'has a valid factory' do
    expect(build(:activity, :resting)).to be_valid
  end

  context 'having at least one activity' do
    before { create(:activity, :resting) }
    it 'is narrowable with behavior name' do
      expect(Activity.where_behavior('RESTING').first.behavior.name).to eq 'RESTING'
    end
  end
end
