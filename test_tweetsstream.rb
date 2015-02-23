# coding: utf-8

#### Global Configuration
## Require
require 'tweetstream'
require "redis"

## TweetStream data
# Consumer key, Secretの設定
CONSUMER_KEY     = "ep4Z9Lby93dEIBTRRL3zjhLaX"
CONSUMER_SECRET  = "00sOIPI3Ao9xxZC4tKE8mKJcXyrIFyPjXICWvL9PTQ2E9qK5RU"
# Access Token Key, Secretの設定
ACCESS_TOKEN_KEY = "259649004-jGmcfoY3HKyOcRfAn3mF5XaU7NxH0MmFurqMY5WO"
ACCESS_SECRET    = "zDAm2De9z8hW6rNTdY4q2EpDiEVJEiG1IhRwJR4CcqUDz"

TweetStream.configure do |config|
  config.consumer_key       = CONSUMER_KEY
  config.consumer_secret    = CONSUMER_SECRET
  config.oauth_token        = ACCESS_TOKEN_KEY
  config.oauth_token_secret = ACCESS_SECRET
  config.auth_method        = :oauth
end

## Redis Connect
redis = Redis.new

#stream = TweetStream::client.new

#TweetStream::Client.new.sample do |status|
#  puts "#{status.text}"
#end


def keyStream(keyword)
  TweetStream::Client.new.track("#{keyword}") do |status|
    if status.user.lang == "ja" && !status.text.index("RT")
      puts "#{status.user.screen_name}: #{status.text}"
    end
  end
end

keyStream("艦これ")
