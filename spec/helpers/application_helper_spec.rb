require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it "convert string time to TimeOfDay object." do
    expect(time_of_day("10:00").class).to eq Tod::TimeOfDay
  end
end
