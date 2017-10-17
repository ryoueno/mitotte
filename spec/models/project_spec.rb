require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'get the first record' do
    before { @project = Project.first }
    it { expect(@project.id).to be_a_kind_of(Integer) }
    it { expect(@project.subject).to be_a_kind_of(String) }
    it { expect(@project.description).to be_a_kind_of(String) }
    it { expect(@project.start_on).to be_a_kind_of(Date) }
    it { expect(@project.end_on).to be_a_kind_of(Date) }
    it { expect(@project.days).to eq 20 }
  end

  context 'get some tasks from first record' do
    before { @project = Project.first }
    it { expect(@project.tasks.count).to eq 5 }
    context 'has some schedules' do
      before { @project = Project.first }
      it { expect(@project.hours).to eq 160 }
      it { expect(@project.minutes).to eq 9595 }
      it { expect(@project.seconds).to eq 575700 }
    end
  end

  context 'get tasks to do from first record' do
    before { @project = Project.first }
    it { expect(@project.todo_tasks.count).to eq 2}
    context 'has some schedules' do
      before { @project = Project.first }
      it { expect(@project.todo_hours).to eq 64 }
      it { expect(@project.todo_minutes).to eq 3838 }
      it { expect(@project.todo_seconds).to eq 230280 }
    end
  end

  context 'make a judgement' do
    before { @project = Project.first }
    context 'in consideration of task status' do
      it { expect(@project.todo_at?(ignore_schedule: true)).to eq true }
    end
    context 'in consideration of schedules' do
      it { expect(@project.todo_at?(ignore_status: true)).to eq true }
    end
    context 'in consideration of both task and schedules' do
      it { expect(@project.todo_at?).to eq true }
    end
  end

  context 'get values indicative progress' do
    before { @project = Project.first }
    context 'passed invalid date object' do
      it { expect(@project.progress([])).to eq [] }
      it { expect(@project.progress([true, 0, '1'])).to eq [0, 0, 0] }
    end
    context 'passed valid date object' do
      it {expect(@project.progress([3.days.ago.to_date, 2.days.ago.to_date, Date.yesterday])).to eq [0.0, 0.0, 0.6]}
      it {expect(@project.progress([Date.today, Date.tomorrow, 2.days.since.to_date])).to eq [0.6, 0.6, 0.6]}
    end
  end
end
