#require "redis"
#redis = Redis.new
#redis.set "foo", "bar"
#puts redis.get "foo"

require 'redis-objects'
redis_url = "redis://127.0.0.1:6379/"
Redis.current = Redis.new(url: redis_url)

@list = Redis::List.new('list_name', :marshal => true)
@list << "a"
@list << "bb"
@list << "ccc"
@list.to_a



@list.delete("a")
@list << "dddd"
@list << "dddd"
@list << "dddd"
@list.to_a
@list.delete("dddd")
@list.to_a
