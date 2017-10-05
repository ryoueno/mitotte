require 'net/http'
require 'uri'
require 'json'

namespace :search_image do
  desc "Search image using Google Search API."
  task :save, ['q'] => :environment do |task, args|
    begin
      uri = URI.encode("#{ENV['GOOGLE_SEARCH_API_URL']}?key=#{ENV['GOOGLE_SEARCH_API_KEY']}&cx=#{ENV['GOOGLE_CUSTOM_SEARCH_ENGINE_ID']}&fields=items(pagemap/cse_thumbnail/src)&q=#{args['q']}")
      uri = URI.parse(uri)
      response = JSON.parse(Net::HTTP.get(uri))
      if response["items"]
        response["items"].map do |item|
          url = item['pagemap']['cse_thumbnail'][0]['src']
          open(Rails.root.join(App::Application.config.screenshots_path, "test", File.basename(url)), 'wb') do |file|
            file.puts(Net::HTTP.get_response(URI.parse(url)).body)
          end
          TestImage.create({:source => url})
        end
        puts "Complete!"
      else
        p args['q']
        puts "Sorry, Could not find image!!"
      end
    rescue => e
      logger.info "タスク実行エラー"
      logger.info e.message
    end
  end
end
