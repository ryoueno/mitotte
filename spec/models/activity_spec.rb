require 'rails_helper'

RSpec.describe Activity, type: :model do
  context 'get the first record' do
    before { @activity = Activity.first }
    it { expect(@activity.id).to be_a_kind_of(Integer) }
    it { expect(@activity.user_id).to be_a_kind_of(Integer) }
    it { expect(@activity.behavior_id).to be_a_kind_of(Integer) }
    it { expect(@activity.target_id).to be_a_kind_of(Integer) }
    it { expect(@activity.update_from).to be_a_kind_of(String) }
    it { expect(@activity.update_to).to be_a_kind_of(String) }
    it { expect(@activity.behavior).to be_valid }
  end
end
