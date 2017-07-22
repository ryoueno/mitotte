module TasksHelper
  def select_time_ampm
    {"AM" => 0, "PM" => 1}.map do |key, val|
      [
        key,
        (1..12).map do |i|
          [sprintf("#{key.downcase} %d:00", i), sprintf("%02d:00", (i + val * 12) === 24 ? 0 : (i + val * 12))]
        end
      ]
    end
  end

  def select_time
    (0..23).map do |i|
      [sprintf("%02d:00", i),sprintf("%02d:00", i)]
    end
  end
end
