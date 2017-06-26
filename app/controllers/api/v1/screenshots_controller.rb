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

  def diff
    screenshots = params.permit(:screenshot1, :screenshot2)
    file1 = screenshots[:screenshot1]
    file2 = screenshots[:screenshot2]
    image1 = file1.read
    image2 = file2.read
    src1 = Digest::MD5.hexdigest(image1)
    src2 = Digest::MD5.hexdigest(image2)
    extension1 = File.extname(file1.original_filename).strip.downcase[1..-1]
    extension2 = File.extname(file2.original_filename).strip.downcase[1..-1]
    output_path1 = Rails.root.join(App::Application.config.screenshots_path, "test", "#{src1}.#{extension1}")
    output_path2 = Rails.root.join(App::Application.config.screenshots_path, "test", "#{src2}.#{extension2}")

    File.open(output_path1, 'w+b') do |fp|
      fp.write image1
    end
    File.open(output_path2, 'w+b') do |fp|
      fp.write image2
    end

    img1 = Magick::Image.read(output_path1).first
    img2 = Magick::Image.read(output_path2).first

    @image_difference = ImageDifference.new(:src1 => "#{src1}.#{extension1}", :src2 => "#{src2}.#{extension1}", :result =>  img1.difference(img2))

    if @image_difference.save
      render json: @image_difference, status: :created
    else
      render json: @image_difference.errors, status: :unprocessable_entity
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
      behavior: "MAYBE_WORKING",
    }.to_json

    uri = URI.parse("#{ENV['GOOGLE_FIREBASE_URL']}#{key}.json")

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Patch.new(uri.request_uri)
    request["Content-Type"] = "application/json"
    response = https.request(request, body)
  end
end
