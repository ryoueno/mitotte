#!/bin/env ruby
# encoding: utf-8

set :output, 'log/cron.log'
ENV.each { |k, v| env(k, v) }

# every 1.minute do
#   q = "programing"
#   rake "search_image:save[#{q}]", :environment => :development
# end

every 1.minute do
  rake "slack:send_result", :environment => :development
end

every 1.day, :at => '8:00 am' do
  rake "slack:send_result", :environment => :production
end

every 30.minute do
  rake "slack:notification", :environment => :production
end
