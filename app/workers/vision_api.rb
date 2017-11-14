require 'base64'
require 'json'
require 'net/https'

class VisionApi
  @queue = 'mitotte'

  def self.perform(url, type, screenshot_id, screenshot_path, max_result=5)
    base64_image = Base64.strict_encode64(File.new(screenshot_path, 'rb').read)

    body = {
      requests: [{
        image: {
          content: base64_image
        },
        features: [
          {
            type: type,
            maxResults: max_result
          }
        ]
      }]
    }.to_json

    uri = URI.parse(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request["Content-Type"] = "application/json"
    response = https.request(request, body)
    response.body = response.body.force_encoding("utf-8")

    logger = Logger.new(File.join(Rails.root, 'log', 'resque.log'))
    logger.info response.body.class

    detection = Detection.new(:screenshot_id => screenshot_id, :mode => type, :data => response.body, :keywords => '{}')

    detection.keywords =
      case type
      when "LOGO_DETECTION"
        JSON.parse(response.body)['responses'][0]['logoAnnotations'].map { |d| d['description'] }
      when "LABEL_DETECTION"
        JSON.parse(response.body)['responses'][0]['labelAnnotations'].map { |d| d['description'] }
      when "TEXT_DETECTION"
        JSON.parse(response.body)['responses'][0]['textAnnotations'].map { |d| d['description'] }
      when "SAFE_SEARCH_DETECTION"
        JSON.parse(response.body)['responses'][0]['safeSearchAnnotation']
      else
        '{}'
      end

    detection.save

    # 不正があればアクティビティに記録
    Activity.interpret(detection)

  end
end
