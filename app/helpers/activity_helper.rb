module ActivityHelper

  include Magick

  def generate_activity_table(activities, date, project)
    behavior_colors = Hash[Behavior.all.map { |row| [row.name, "##{row.color_code}"] }]
    behavior_colors['DEFAULT'] = "#ebedf0"
    x_label_w = 20
    y_label_h = 20
    footer_h = 60
    c_w = 20
    c_h = 20
    f_m = 30
    c_m = 6
    c_num_w = 24
    c_num_h = 6
    img_w = x_label_w + (f_m * 2) + (c_w + c_m) * c_num_w - c_m
    img_h = y_label_h + (f_m * 2) + (c_h + c_m) * c_num_h - c_m + footer_h
    canvas = Image.new(img_w, img_h)
    dr = Draw.new
    dr.stroke_width(1)
    c_num_w.times do |hour|
      c_num_h.times do |minute|
        if activities[sprintf("%02d:%02d", hour + 1, minute * 10)]
          dr.fill('#' + activities[sprintf("%02d:%02d", hour + 1, minute * 10)].behavior.color_code)
        elsif project.todo_at?(date: date, time: Tod::TimeOfDay.new(hour, minute))
          #TODO
          dr.fill(behavior_colors['LAZY'])
        else
          dr.fill(behavior_colors['DEFAULT'])
        end
        dr.rectangle(
          x_label_w + f_m + (hour*(c_m + c_w)),
          y_label_h + f_m + (minute*(c_m + c_h)),
          x_label_w + f_m + (hour*(c_m + c_w)) + c_w,
          y_label_h + f_m + (minute*(c_m + c_h)) + c_h,
        )
      end
    end

    # # Label
    dr.font = 'DejaVu-Sans'
    dr.stroke('transparent')
    dr.fill('#666')
    dr.pointsize = 16 # 文字サイズ

    # X Label
    dr.text(50, 36, "00")
    dr.text(180, 36, "06")
    dr.text(335, 36, "12")
    dr.text(491, 36, "18")
    dr.text(647, 36, "23")

    # Y Label
    dr.text(16, 66, "00")
    dr.text(16, 132, "30")
    dr.text(16, 196, "60")

    # Footer
    dr.fill(behavior_colors['RUNNING'])
    dr.rectangle(50, 220, 50 + c_w, 220 + c_h)
    dr.fill(behavior_colors['RESTING'])
    dr.rectangle(361, 220, 361 + c_w, 220 + c_h)
    dr.fill(behavior_colors['DEFAULT'])
    dr.rectangle(50, 246, 50 + c_w, 246 + c_h)
    dr.fill(behavior_colors['LAZY'])
    dr.rectangle(361, 246, 361 + c_w, 246 + c_h)

    dr.fill('#666')

    dr.text(86, 238, "WORKING")
    dr.text(397, 238, "RESTING")
    dr.text(86, 264, "OFF")
    dr.text(397, 264, "LAZY")

    # 描画、保存
    dr.draw(canvas)

    canvas.write(Rails.root.join(App::Application.config.activity_graph_path, "#{project.user.id}_#{date.strftime('%Y%m%d')}.png"))
  end

  def generate_progress_graph
    g = Gruff::Bezier.new
    g.theme= {
      :colors => ["#fff", "#c0ca33"],
      :marker_color => "#fff",
      :background_colors => "#fff",
      :font_color => "#666",
    }
    g.legend_margin = 100
    g.marker_font_size = 12
    progress_label = ProgressLabel.new(@project.start_on, @project.end_on)
    g.labels = progress_label.get_label

    # グラフを大きく見せるために仕方なく
    dummy_data = (0..g.labels.count - 1).to_a.map {|d| d * 200}
    g.data :Dammy, dummy_data

    # 進捗データ
    g.data :TODO, @project.progress(progress_label.get_label, dummy_data.last)

    g.font = 'DejaVu-Sans'
    save_path = Rails.root.join(App::Application.config.project_graph_path, "#{@project.id}_#{@the_day.strftime('%Y%m%d')}.png")
    g.write(save_path)

    # グラフを編集
    img = Magick::Image.read(save_path).first

    # 現在時点アイコン追加
    icon = Magick::Image.read('public/images/dogs/dog_icon.png').first
    icon.resize!(60, 40)
    img = img.crop(Magick::SouthEastGravity, 680, 450)
    graph_width = 680 #推定ベース画像サイズ
    img.composite!(icon, progress_label.now_position * graph_width / progress_label.max_period, 300, Magick::OverCompositeOp)

    # 追加描画
    img.write(save_path)
  end
end
