require 'rails_helper'

RSpec.describe User, type: :model do
  context 'get the first record' do
    before { @user = User.first }
    it { expect(@user.id).to be_a_kind_of(Integer) }
    it { expect(@user.name).to be_a_kind_of(String) }
    it { expect(@user.email).to be_a_kind_of(String) }
  end
  it 'set keyword before save'
end
