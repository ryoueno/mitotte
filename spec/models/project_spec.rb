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

  context 'divide project date for progress graph label' do
    it 'is equal start-date and first period' do
      project = create(:project)
      expect(project.gruff_period.first).to eq project.start_at
    end

    it 'is equal end-date and last period if number of period is more than project days' do
      project = create(:project)
      max_period = 10
      expect(project.gruff_period(max_period).last).to eq project.end_at
    end

    it 'is equal number of period and specified max_period' do
      project = create(:project)
      max_period = 5
      expect(project.gruff_period(max_period).length).to eq max_period
    end
  end

  context 'get label for progress graph divided periods' do
    it 'is equal number of available periods and labels' do
      project = create(:project)
      blank_num = 1
      expect(project.get_label.length - blank_num).to eq project.gruff_period.length
    end

    it 'is available label in specific format' do
      project = create(:project)
      expect(project.get_label[1]).to eq project.start_at.strftime("%m/%d")
    end
  end

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

  it 'make a judgment to do now' do
    expect(create(:project).todo?(Date.today, Tod::TimeOfDay.new(9, 0, 0))).to be true
  end
end
