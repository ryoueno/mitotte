require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    create(:task_status, :initial)
    create(:task_status, :pending)
    create(:task_status, :progress)
    create(:task_status, :done)
    create(:task_status, :rejected)
  end

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
    create(:activity, :change_status_1_to_2)
    expect(task.todo_at?(time: Tod::TimeOfDay.new(19, 0, 0))).to be true
  end

  describe 'Make a judgement to do task itself' do
    context 'status is [todo] value' do
      it 'return true' do
        task = create(:task)
        create(:activity, :change_status_1_to_2, target_id: task.id)
        expect(task.todo?).to be true
      end
    end

    context 'status is not [todo] value' do
      it 'return false' do
        task = create(:task)
        create(:activity, :change_status_1_to_2, target_id: task.id)
        expect(task.todo?).to be false
      end
    end
  end
end
