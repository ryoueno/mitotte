require 'rails_helper'

RSpec.describe Behavior, type: :model do
  context 'get the first record' do
    before { @behavior = Behavior.first }
    it { expect(@behavior.id).to be_a_kind_of(Integer) }
    it { expect(@behavior.name).to be_a_kind_of(String) }
    it { expect(@behavior.display).to be_a_kind_of(String) }
    it { expect(@behavior.color_code.length).to eq 6 }
    it { expect(@behavior.priority).to be_a_kind_of(Integer) }
  end
end
