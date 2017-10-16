require 'rails_helper'

RSpec.describe ProgressLabel do
  context 'instantiate ProgressLabel' do
    it 'raise exception to inconsistent date' do
      expect{ProgressLabel.new(1.days.since.to_date, Date.today)}.to raise_error(ArgumentError)
    end

    it 'is available max_period as default value' do
      expect(ProgressLabel.new(1.days.ago.to_date, Date.today).max_period).to eq 10
    end

    it 'is available now_position as default value zero.' do
      expect(ProgressLabel.new(1.days.ago.to_date, Date.today).now_position).to eq 0
    end
  end

  context 'Set up datetime list using label of Label' do
    context 'top date pattern' do
      context 'Less periods than max_period' do
        progress = ProgressLabel.new(Date.today, 5.days.since.to_date)
        it 'is available hash object cover to given dates' do
          expect(progress.gruff_period.size).to eq 5 + 1
        end

        it 'is equal the first periods and today' do
          expect(progress.gruff_period.first).to eq progress.now_date
        end

        it 'is equal the end periods and 5 days since' do
          expect(progress.gruff_period.last).to eq 5.days.since.to_date
        end

        it 'has @now_position set to first position' do
          expect(progress.now_position).to eq 0
        end
      end

      context 'More periods than max_period' do
        progress = ProgressLabel.new(Date.today, 15.days.since.to_date)
        it 'is available hash object equal to max_period (10)' do
          expect(progress.gruff_period.size).to eq progress.max_period
        end

        it 'is equal the first periods and today' do
          expect(progress.gruff_period.first).to eq progress.now_date
        end

        it 'is equal the end periods and @max_period days since' do
          expect(progress.gruff_period.last).to eq 15.days.since.to_date
        end

        it 'has @now_position set to first position' do
          expect(progress.now_position).to eq 0
        end
      end
    end

    context 'bottom date pattern' do
      context 'Less periods than max_period' do
        progress = ProgressLabel.new(5.days.ago.to_date, Date.today)
        it 'is available hash object cover to given dates' do
          expect(progress.gruff_period.size).to eq 5 + 1
        end

        it 'is equal the first periods and 5 days ago' do
          expect(progress.gruff_period.first).to eq 5.days.ago.to_date
        end

        it 'is equal the end periods and today' do
          expect(progress.gruff_period.last).to eq progress.now_date
        end

        it 'has @now_position set to first position' do
          expect(progress.now_position).to eq 5
        end
      end

      context 'More periods than max_period' do
        progress = ProgressLabel.new(15.days.ago.to_date, Date.today)
        it 'is available hash object equal to max_period (10)' do
          expect(progress.gruff_period.size).to eq progress.max_period
        end

        it 'is equal the first periods and 15 days ago' do
          expect(progress.gruff_period.first).to eq 15.days.ago.to_date
        end

        it 'is equal the end periods and today' do
          expect(progress.gruff_period.last).to eq progress.now_date
        end

        it 'has @now_position set to first position' do
          expect(progress.now_position).to eq progress.max_period - 1
        end
      end
    end

    context 'middle date pattern' do
      context 'Less periods than max_period' do
        progress = ProgressLabel.new(3.days.ago.to_date, 3.days.since.to_date)
        it 'is available hash object cover to given dates' do
          expect(progress.gruff_period.size).to eq 3 + 1 + 3
        end

        it 'is equal the first periods and 3 days ago' do
          expect(progress.gruff_period.first).to eq 3.days.ago.to_date
        end

        it 'is equal the end periods and 3 days since' do
          expect(progress.gruff_period.last).to eq 3.days.since.to_date
        end

        it 'has @now_position set to first position' do
          expect(progress.now_position).to eq 3
        end
      end

      context 'More periods than max_period' do
        progress = ProgressLabel.new(7.days.ago.to_date, 7.days.since.to_date)
        it 'is available hash object equal to max_period (10)' do
          expect(progress.gruff_period.size).to eq progress.max_period
        end

        it 'is equal the first periods and 7 days ago' do
          expect(progress.gruff_period.first).to eq 7.days.ago.to_date
        end

        it 'is equal the end periods and 7 days since' do
          expect(progress.gruff_period.last).to eq 7.days.since.to_date
        end

        it 'has @now_position set to first position' do
          expect(progress.now_position).to eq 7
        end
      end
    end
  end
end
