class ActivityController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  require 'gruff'
  def index
    @project = Project.find(params[:project_id])
    @user = @project.user
    @the_day = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)

    g = Gruff::Bezier.new
    g.theme= {
      :colors => ["#fff", "#c0ca33"],
      :marker_color => "#fff",
      :background_colors => "#fff",
      :font_color => "#666"
    }
    g.legend_margin = 100
    g.marker_font_size = 12
    g.labels = @project.get_label
    g.data :Dammy, (0..g.labels.count - 1).to_a.map {|d| d * 200}
    g.data :TODO, @project.progress
    g.font = 'DejaVu-Sans'
    save_path = Rails.root.join(App::Application.config.project_graph_path, "#{@project.id}_#{@the_day.strftime('%Y%m%d')}.png")
    g.write(save_path)

    # グラフを編集
    img = Magick::Image.read(save_path).first
    icon = Magick::Image.read('public/images/dogs/dog_icon.png').first
    icon.resize!(60, 40)
    img = img.crop(Magick::SouthEastGravity, 680, 450)
    img.composite!(icon, 380, 300, Magick::OverCompositeOp)
    img.write(save_path)

    @activities = @user.activities.aggregate @the_day
    view_context.create(@activities, @the_day, @project)
    render 'guest' and return if params[:keyword] == @user.keyword
    render 'auth' if (not current_user) || @user.id != current_user.id
  end
end
