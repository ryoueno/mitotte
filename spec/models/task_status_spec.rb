require 'rails_helper'

RSpec.describe TaskStatus, type: :model do
  context 'get the first record' do
    before { @task_status = TaskStatus.first }
    it { expect(@task_status.id).to be_a_kind_of(Integer) }
    it { expect(@task_status.name).to be_a_kind_of(String) }
    it { expect(@task_status.display).to be_a_kind_of(String) }
  end
end
