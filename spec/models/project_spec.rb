require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'has a valid factory' do
    expect(build(:project)).to be_valid
  end

  context 'there are some tasks' do
    it 'is available the number of tasks' do
      expect(create(:project).tasks.count).to eq 1
    end

    context 'countable' do
      it 'has one task to do' do
        project = create(:project)
        tasks = project.tasks
        task = tasks.first
        task.update(:task_status_id => TaskStatus::where(:name => 'INITIAL').first.id)
        expect(project.todo_tasks(time: Tod::TimeOfDay.new(9, 0, 0)).count).to eq 1
      end
      it 'has no task to do' do
        project = create(:project)
        tasks = project.tasks
        task = tasks.first
        task.update(:task_status_id => TaskStatus::where(:name => 'DONE').first.id)
        expect(project.todo_tasks(time: Tod::TimeOfDay.new(9, 0, 0)).count).to eq 0
      end
    end
  end

  it 'is available the values indicative progress'

  it 'is available number of days' do
    expect(create(:project).days).to eq 10
  end

  it 'is available time in hours' do
    expect(create(:project).hours).to eq 8
  end

  it 'is available time in minutes' do
    expect(create(:project).minutes).to eq 480
  end

  it 'is available time in seconds' do
    expect(create(:project).seconds).to eq 28800
  end

  context 'Make a judgment' do
    it 'returns true when its status is [todo] now' do
      project = create(:project)
      tasks = project.tasks
      task = tasks.first
      task.update(:task_status_id => TaskStatus::where(:name => 'INITIAL').first.id)
      expect(project.todo_at?(time: Tod::TimeOfDay.new(9, 0, 0))).to be true
    end
    it 'returns false when its status is not [todo] now' do
      project = create(:project)
      tasks = project.tasks
      task = tasks.first
      task.update(:task_status_id => TaskStatus::where(:name => 'DONE').first.id)
      expect(project.todo_at?(time: Tod::TimeOfDay.new(9, 0, 0))).to be false
    end
  end
end
