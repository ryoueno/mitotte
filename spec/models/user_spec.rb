require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid within 6 characters' do
    user = build(:user)
    user.password = "test"
    expect(user).to be_invalid
  end

  it 'is set keyword before save' do
    user = create(:user)
    expect(User.keywords.include?(user.keyword)).to be true
  end
end
