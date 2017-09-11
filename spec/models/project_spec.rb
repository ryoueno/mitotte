require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'has a valid factory' do
    expect(build(:project)).to be_valid
  end

  context 'there are some tasks' do
    it 'is available the number of tasks' do
      expect(create(:project).all_task_num).to eq 1
    end

    it 'count task to do' do
      project = create(:project)
      project.tasks.first.update!(status: TaskStatus::STATUS[:INITIAL])
      expect(project.todo_task_num).to eq 1
    end

    it 'count task that it do not have to do' do
      project = create(:project)
      project.tasks.first.update!(status: TaskStatus::STATUS[:DONE])
      expect(project.todo_task_num).to eq 0
    end
  end

  it 'is available the values indicative progress'

  it 'is available the label data used progress graph'

  it 'is available time in hours' do
    expect(create(:project).hours).to eq 8
  end

  it 'is available time in minutes' do
    expect(create(:project).minutes).to eq 480
  end

  it 'is available time in seconds' do
    expect(create(:project).seconds).to eq 28800
  end

  it 'make a judgment to do now' do
    expect(create(:project).todo?(Date.today, Tod::TimeOfDay.new(9, 0, 0))).to be true
  end
end
