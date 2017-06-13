class Api::V1::ScreenshotsController < ApplicationController
  protect_from_forgery except: :create
  def create
    file = fileupload_params[:screenshot]
    image = file.read
    src = Digest::MD5.hexdigest(image)
    extension = File.extname(file.original_filename).strip.downcase[1..-1]
    output_path = Rails.root.join(App::Application.config.screenshots_path, "#{src}.#{extension}")

    File.open(output_path, 'w+b') do |fp|
      fp.write image
    end

    @screenshot = Screenshot.new(:uuid => fileupload_params[:uuid], :src => src, :extension => extension)

    if @screenshot.save
      # Create job detect information from screenshot by using Cloud Vision API.
      api_key = ENV['GOOGLE_API_KEY']
      api_url = ENV['GOOGLE_CLOUD_VISION_API_URL']
      url = "#{api_url}?key=#{api_key}"
      types = ["LOGO_DETECTION", "LABEL_DETECTION", "TEXT_DETECTION", "SAFE_SEARCH_DETECTION"]

      types.each do |type|
        Resque.enqueue(VisionApi, url, type, @screenshot.id, @screenshot.path)
      end

      render json: @screenshot, status: :created
    else
      render json: @screenshot.errors, status: :unprocessable_entity
    end
  end

  private

  def fileupload_params
    params.permit(:uuid, :screenshot)
  end
end
