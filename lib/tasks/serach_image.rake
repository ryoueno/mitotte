require 'net/http'
require 'uri'
require 'json'

namespace :serach_image do
  desc "Search image using Google Search API."
  task :save, ['q'] => :environment do |task, args|
    uri = URI.encode("#{ENV['GOOGLE_SEARCH_API_URL']}?key=#{ENV['GOOGLE_SEARCH_API_KEY']}&cx=#{ENV['GOOGLE_CUSTOM_SEARCH_ENGINE_ID']}&fields=items(pagemap/cse_thumbnail/src)&q=#{args['q']}")
    uri = URI.parse(uri)
    response = JSON.parse(Net::HTTP.get(uri))
    if response["items"]
      response["items"].map { |item| TestImage.create({:source => item['pagemap']['cse_thumbnail'][0]['src']}) }
      puts "Complete!"
    else
      puts "Sorry, Could not find image!!"
    end
  end
end
