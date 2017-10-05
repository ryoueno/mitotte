#!/bin/env ruby
# encoding: utf-8

set :output, '/usr/src/app/log/crontab.log'
ENV.each { |k, v| env(k, v) }

every 1.minute do
  q = "programing"
  rake "search_image:save[#{q}]", :environment => :development
end
