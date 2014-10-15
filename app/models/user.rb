class User < ActiveRecord::Base
  attr_accessible :gender_array, :name, :orientation_array, :provider
  # has_many :reports
  serialize :gender_array, Array
  serialize :orientation_array, Array
  
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['CONSUMER_KEY']
    config.consumer_secret     = ENV['CONSUMER_SECRET']
    config.access_token        = ENV['ACCESS_TOKEN']  # This will be a variable grabbed from env['omniauth.auth']
    config.access_token_secret = ENV['ACCESS_SECRET'] # This will be a variable grabbed from env['omniauth.auth']
  end

  # binding.pry

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end
  
  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end
  
  # Remove commas, spaces and the subString "and" from a string and convert the String into an Array of Strings
  #
  # Example:
  #
  # "red,dark blue, and ,green".string_to_array
  # => ["red", "dark", "blue", "green"]
  #
  # Returns and Array of Strings
  def string_to_array(string)
    string.gsub(',', ' ').gsub('and', ' ').split(' ')
  end
  
  def array_of_followers_ids
  end
  
end
