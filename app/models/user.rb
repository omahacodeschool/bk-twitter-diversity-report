class User < ActiveRecord::Base
  attr_accessible :age_array, :gender_array, :name, :race_array
  
  has_many :reports
  
  # client = Twitter::REST::Client.new do |config|
#     config.consumer_key        = ENV['CONSUMER_KEY']
#     config.consumer_secret     = ENV['CONSUMER_SECRET']
#     # config.access_token        = "YOUR_ACCESS_TOKEN"
#     # config.access_token_secret = "YOUR_ACCESS_SECRET"
#   end
end
