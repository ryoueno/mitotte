class ProgressGraph
  attr_reader :now_position
  attr_accessor :max_period, :now_date

  MAX_GRUFF_PERIOD = 10

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    if start_date > end_date
      raise ArgumentError, "start_date must be same or earlier than end_date."
    end
    @now_date = Date.today
    @now_position = 0
    @max_period = MAX_GRUFF_PERIOD
  end

  # @start_date 及び @end_date を 指定された数に収まるように削り分ける
  def gruff_period
    # 配列にプロジェクト期間の日付データを全て格納
    periods = []
    (@start_date..@end_date).each_with_index do |date, idx|
      periods.push date
      @now_position = idx if date == @now_date && periods.count <= @max_period
    end

    # (max_periodを上回っている場合に)圧縮
    zip_periods(periods)
  end

  def get_label
    label = {}
    label[0] = ''
    gruff_period.each_with_index do |t, idx|
      label[idx + 1] = t.strftime("%m/%d")
    end
    label
  end

  private

  # @max_period のサイズでperiodsを圧縮する
  def zip_periods(periods)
    if periods.count > @max_period
      div = periods.count / (@max_period) #ほどよい区切り長
      data = periods
      periods = []
      @max_period.times do |t|
        periods[t] = data[t * div]
        # 今日に一番近い日付を @now_positionに設定
        @now_position = t if (@now_date - data[t * div]).abs < (@now_date - data[@now_position]).abs
      end
      periods[0] = @start_date
      periods[periods.count - 1] = @end_date
    end
    periods
  end
end
