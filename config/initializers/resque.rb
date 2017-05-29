Resque.redis = ENV['REDIS_HOST']
Resque.redis.namespace = "resque:#{ENV['RESQUE_QUEUE_NAME']}:#{Rails.env}"
