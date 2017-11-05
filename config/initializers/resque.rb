Resque.redis = Redis.new(
  :host     => ENV['REDIS_HOST'].present?      ? ENV['REDIS_HOST'] : '127.0.0.1',
  :port     => ENV['REDIS_PORT'].present?      ? ENV['REDIS_PORT'] : 6379,
  :password => ENV['REDIS_PASSOWRD'].present?  ? ENV['REDIS_PASSOWRD'] : nil
)
Resque.redis.namespace = "resque:#{ENV['RESQUE_QUEUE_NAME']}:#{Rails.env}"
