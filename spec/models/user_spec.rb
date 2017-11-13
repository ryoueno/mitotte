require 'rails_helper'

RSpec.describe User, type: :model do
  context 'get the first record' do
    before { @user = User.first }
    it { expect(@user.id).to be_a_kind_of(Integer) }
    it { expect(@user.name).to be_a_kind_of(String) }
    it { expect(@user.email).to be_a_kind_of(String) }
  end

  context 'make a judgement' do
    before { @user = User.first }
    context 'in consideration of task status' do
      it { expect(@user.todo_at?(ignore_schedule: true)).to eq true }
    end
    context 'in consideration of schedules' do
      it { expect(@user.todo_at?(ignore_status: true)).to eq true }
    end
    context 'in consideration of both task and schedules' do
      it { expect(@user.todo_at?).to eq true }
    end
  end
end
