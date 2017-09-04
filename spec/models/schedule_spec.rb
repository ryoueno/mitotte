require 'rails_helper'

describe Schedule, type: :model do
  it 'has a valid factory' do
    expect(build(:schedule)).to be_valid
  end

  it 'is available time_sets as ScheduleTime object' do
    expect(create(:schedule).time[0].kind_of?(ScheduleTime)).to be true
  end

  it 'is available time in hours' do
    expect(create(:schedule).hours).to eq 4
  end

  it 'is available time in minutes' do
    expect(create(:schedule).minutes).to eq 240
  end

  it 'is available time in seconds' do
    expect(create(:schedule).seconds).to eq 14400
  end

  it 'make a judgment to do now' do
    expect(create(:schedule).todo?(Tod::TimeOfDay.new(9, 0, 0))).to be true
  end
end
