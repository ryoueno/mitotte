require 'json'
require 'net/https'

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

    uuid = fileupload_params[:uuid]
    uuid = "MISSING_UUID_USER" if fileupload_params[:uuid].nil?

    @screenshot = Screenshot.new(:uuid => uuid, :src => src, :extension => extension)

    if @screenshot.save
      # Create job detect information from screenshot by using Cloud Vision API.
      api_key = ENV['GOOGLE_API_KEY']
      api_url = ENV['GOOGLE_CLOUD_VISION_API_URL']
      url = "#{api_url}?key=#{api_key}"
      types = ["LOGO_DETECTION", "LABEL_DETECTION", "TEXT_DETECTION", "SAFE_SEARCH_DETECTION"]

      types.each do |type|
        Resque.enqueue(VisionApi, url, type, @screenshot.id, @screenshot.path)
      end

      set_firebase uuid

      render json: @screenshot, status: :created
    else
      render json: @screenshot.errors, status: :unprocessable_entity
    end
  end

  private

  def fileupload_params
    params.permit(:uuid, :screenshot)
  end

  def set_firebase(uuid)
    key = "activity/#{uuid}"

    body = {
      time: Time.now.strftime("%Y-%m-%d %H:%M:%S"),
    }.to_json

    uri = URI.parse("#{ENV['GOOGLE_FIREBASE_URL']}#{key}.json")

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request["Content-Type"] = "application/json"
    response = https.request(request, body)
  end
end
