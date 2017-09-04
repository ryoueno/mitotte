require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'has a valid factory' do
    expect(build(:task)).to be_valid
  end

  it 'is available time in hours' do
    expect(create(:task).hours).to eq 8
  end

  it 'is available time in minutes' do
    expect(create(:task).minutes).to eq 480
  end

  it 'is available time in seconds' do
    expect(create(:task).seconds).to eq 28800
  end

  it 'make a judgment to do now' do
    expect(create(:task).todo?(Date.today, Tod::TimeOfDay.new(19, 0, 0))).to be true
  end
end
