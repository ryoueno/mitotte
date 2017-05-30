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

    response_model = Detection.new(:screenshot_id => screenshot_id, :mode => type, :data => response.body)
    response_model.save

    logger = Logger.new(File.join(Rails.root, 'log', 'resque.log'))
    logger.info response.body
  end
end
