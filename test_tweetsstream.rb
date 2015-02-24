# coding: utf-8

#### Global Configuration
## Require
require 'tweetstream'
require 'redis-objects'

## TweetStream data
fp = open(".config")
config = []
fp.each do |item|
  config << item.to_s.strip
end 

# Consumer key, Secretの設定
CONSUMER_KEY     = config[0]
CONSUMER_SECRET  = config[1]
# Access Token Key, Secretの設定
ACCESS_TOKEN_KEY = config[2]
ACCESS_SECRET    = config[3]
fp.close

TweetStream.configure do |config|
  config.consumer_key       = CONSUMER_KEY
  config.consumer_secret    = CONSUMER_SECRET
  config.oauth_token        = ACCESS_TOKEN_KEY
  config.oauth_token_secret = ACCESS_SECRET
  config.auth_method        = :oauth
end

##
## メインストリーミング
##
## 1.キーを与えて指定したDBに全てのデータを保存したメインストリーミングを作る
## 2.各タグごとのストリーミングを作る関数を呼ぶ
##
def keyStream(num,keyword)
  redis_url = "redis://127.0.0.1:6379/#{num}"
  Redis.current = Redis.new(url: redis_url)
  @list = Redis::List.new("list_#{keyword}", :marshal => true)
  TweetStream::Client.new.track("#{keyword}") do |status|
   if status.user.lang == "ja" && !status.text.index("RT")
      if nil != status.text.match(/\#/)
#        puts "#{status.user.screen_name}:( #{status.id} )  #{status.text}"
        @list << "#{status.user.screen_name}" + "#{status.text}"
        parser_tag(status)
      end
    end
  end
end


## タグパーサ
def parser_tag(status)
puts   status.text
#
#puts status.text.split(/\#/)
#
  
  ## To Do
  ## このへんにタグを全て抽出して、
  ## 再帰的に全てのタグごとに関数を読む記述をする
  ## 
end


## タグごとにストリームを保存
def save_stream(tag,status)
  redis_url = "redis://127.0.0.1:6379/"
  Redis.current = Redis.new(url: redis_url)
  @list = Redis::List.new("list_#{tag}", :marshal => true)
  @list << ["#{status.user.screen_name}","#{status.text}"] 
end  

keyStream(0,"pic")

#  redis_url = "redis://127.0.0.1:6379/0"
#  Redis.current = Redis.new(url: redis_url)
#  @list = Redis::List.opena('list_pic', :marshal => true)
#  puts @list.to_a
