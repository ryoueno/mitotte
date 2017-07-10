set :output, '/usr/src/app/log/crontab.log'
ENV.each { |k, v| env(k, v) }

every 1.minute do
  runner "Test.check", :environment => :development
end
