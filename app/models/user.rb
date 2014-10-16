class User < ActiveRecord::Base
  attr_accessible :gender_string, :orientation_string, :name, :gender_array, :orientation_array, :uid, :provider

  attr_reader :gender_string, :orientation_string
  # has_many :reports
  serialize :gender_array, Array
  serialize :orientation_array, Array
  
  $client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['CONSUMER_KEY']
    config.consumer_secret     = ENV['CONSUMER_SECRET']
    # config.access_token        = ENV['ACCESS_TOKEN']  # This will be a variable grabbed from env['omniauth.auth']
    # config.access_token_secret = ENV['ACCESS_SECRET'] # This will be a variable grabbed from env['omniauth.auth']
  end


  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end
  
  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
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
  def string_to_array
    self.gsub(',', ' ').gsub('and', ' ').split(' ')
  end
  
  def self.friends_ids_array(twitter_name)
    
    id_arr = []
    friends = $client.friends(twitter_name)
  
    friends.each do |f|
      id_arr << f.id
    end
    id_arr
  end
  
  def gender_string=(gender_string)
    self.gender_array=gender_string.gsub(',', ' ').gsub('and', ' ').split(' ')
  end
  
  def orientation_string=(orientation_string)
    self.orientation_array=orientation_string.gsub(',', ' ').gsub('and', ' ').split(' ')
  end

end
