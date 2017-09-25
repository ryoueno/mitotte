require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'has a valid factory' do
    expect(build(:task)).to be_valid
  end

  it 'is available time in hours' do
    expect(create(:task).hours).to eq 8
  end

  it 'is available time in minutes' do
    expect(create(:task).minutes).to eq 480
  end

  it 'is available time in seconds' do
    expect(create(:task).seconds).to eq 28800
  end

  it 'make a judgment to do now' do
    task = create(:task)
    task.update!(task_status_id: TaskStatus::where(:name => 'INITIAL').first.id)
    expect(task.todo_at?(time: Tod::TimeOfDay.new(19, 0, 0))).to be true
  end

  context 'Make a judgement to do task itself' do
    it 'return true when the status is [todo] value' do
      task = create(:task)
      task.update!(task_status_id: TaskStatus::where(:name => 'INITIAL').first.id)
      expect(task.todo?).to be true
    end

    it 'return false when the status is not [todo] value' do
      task = create(:task)
      task.update!(task_status_id: TaskStatus::where(:name => 'DONE').first.id)
      expect(task.todo?).to be false
    end
  end
end
