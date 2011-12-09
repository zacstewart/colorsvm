ENV['REDISTOGO_URL'] ||= 'redis://127.0.0.1:6379'
uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.redis = REDIS
