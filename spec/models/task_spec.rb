require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'get the first record' do
    before { @task = Task.first }
    it { expect(@task.id).to be_a_kind_of(Integer) }
    it { expect(@task.project).to be_valid }
    it { expect(@task.description).to be_a_kind_of(String) }
  end

  context 'has some schedules' do
    before { @task = Task.first }
    it { expect(@task.hours).to eq 32 }
    it { expect(@task.minutes).to eq 1919 }
    it { expect(@task.seconds).to eq 115140 }
  end

  context 'has a status' do
    before { @task = Task.first }
    it { expect(@task.status.name).to eq 'DONE' }
  end

  context 'make a judgement' do
    before { @task = Task.first }
    context 'in consideration of task status' do
      it { expect(@task.todo_at?(ignore_schedule: true)).to eq false }
    end
    context 'in consideration of schedules' do
      it { expect(@task.todo_at?(ignore_status: true)).to eq true }
    end
    context 'in consideration of both task and schedules' do
      it { expect(@task.todo_at?).to eq false }
    end
  end
end
