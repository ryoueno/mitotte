require 'rails_helper'

RSpec.describe Screenshot, type: :model do
  before do
    @screenshot1 = create(:screenshot, :src => "test_screenshot1")
    @screenshot2 = create(:screenshot, :src => "test_screenshot2", :created_at => @screenshot1.created_at + 3.minutes)
  end

  it 'has a valid factory' do
    expect(@screenshot1).to be_valid
    expect(@screenshot2).to be_valid
  end

  it 'return file name in [src + extension] format' do
    expect(@screenshot1.name).to eq 'test_screenshot1.png'
    expect(@screenshot2.name).to eq 'test_screenshot2.png'
  end

  it 'return file path in [/path/to/file/ + src + extension] format' do
    expect(@screenshot1.path).to eq Rails.root.to_s + '/public/images/screenshots/test_screenshot1.png'
    expect(@screenshot2.path).to eq Rails.root.to_s + '/public/images/screenshots/test_screenshot2.png'
  end

  it 'return screenshot created a certain period of time' do
    expect(@screenshot2.recent.name).to eq @screenshot1.name
  end

  it 'calculate difference point per pixel' do
    expect(@screenshot2.error_per_pixel.to_i).to eq 1812
  end

  it 'make a judgment whether recent screenshot is similar' do
    expect(@screenshot2.similar?).to be true
  end
end
