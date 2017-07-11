module ActivityHelper

  include Magick

  def create(activities, date, project)
    x_label_w = 20
    y_label_h = 20
    footer_h = 60
    c_w = 20
    c_h = 20
    f_m = 30
    c_m = 6
    c_num_w = 25
    c_num_h = 6
    img_w = x_label_w + (f_m * 2) + (c_w + c_m) * c_num_w - c_m
    img_h = y_label_h + (f_m * 2) + (c_h + c_m) * c_num_h - c_m + footer_h
    canvas = Image.new(img_w, img_h)
    dr = Draw.new
    dr.stroke_width(1)
    c_num_w.times do |hour|
      c_num_h.times do |minute|
        if activities[sprintf("%02d:%02d", hour, minute * 10)]
          dr.fill(activities[sprintf("%02d:%02d", hour, minute * 10)].behavior_color)
        else
          dr.fill(Activity::COLOR_DEFAULT)
        end
        dr.rectangle(
          x_label_w + f_m + (hour*(c_m + c_w)),
          y_label_h + f_m + (minute*(c_m + c_h)),
          x_label_w + f_m + (hour*(c_m + c_w)) + c_w,
          y_label_h + f_m + (minute*(c_m + c_h)) + c_h,
        )
      end
    end

    # Label
    dr.font = 'DejaVu-Sans'
    dr.stroke('transparent')
    dr.fill('#666')
    dr.pointsize = 16 # 文字サイズ

    # X Label
    dr.text(50, 36, "00")
    dr.text(180, 36, "06")
    dr.text(335, 36, "12")
    dr.text(491, 36, "18")
    dr.text(673, 36, "24")

    # Y Label
    dr.text(16, 66, "00")
    dr.text(16, 132, "30")
    dr.text(16, 196, "60")

    # Footer
    dr.fill(Activity::COLOR_RUNNING)
    dr.rectangle(50, 220, 50 + c_w, 220 + c_h)
    dr.fill(Activity::COLOR_RESTIMG)
    dr.rectangle(361, 220, 361 + c_w, 220 + c_h)
    dr.fill(Activity::COLOR_DEFAULT)
    dr.rectangle(50, 246, 50 + c_w, 246 + c_h)
    dr.fill(Activity::COLOR_MOVING)
    dr.rectangle(361, 246, 361 + c_w, 246 + c_h)

    dr.fill('#666')

    dr.text(86, 238, "WORKING")
    dr.text(397, 238, "RESTING")
    dr.text(86, 264, "OFF")
    dr.text(397, 264, "NOT WORKING")

    # 描画、保存
    dr.draw(canvas)

    canvas.write(Rails.root.join(App::Application.config.activity_graph_path, "#{project.user.id}_#{date.strftime('%Y%m%d')}.png"))
  end
end
