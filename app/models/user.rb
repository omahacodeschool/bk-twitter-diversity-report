class User < ActiveRecord::Base
  attr_accessible :gender_array, :name, :orientation_array, :provider
  # has_many :reports
  serialize :gender_array, Array
  serialize :orientation_array, Array
  
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['CONSUMER_KEY']
    config.consumer_secret     = ENV['CONSUMER_SECRET']
    config.access_token        = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_SECRET']
  end

  binding.pry
  
  def string_to_array(string)
    string.split(" ")
  end
  
end
