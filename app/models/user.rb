class User < ActiveRecord::Base
  require 'core'
  attr_accessible :gender_string, :orientation_string, :name, :gender_array, :orientation_array, :uid, :provider

  attr_reader :gender_string, :orientation_string
  has_many :reports
  serialize :gender_array, Array
  serialize :orientation_array, Array
  
  $client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['CONSUMER_KEY']
    config.consumer_secret     = ENV['CONSUMER_SECRET']
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
  # def string_to_array
  #   self.gsub(',', ' ').gsub('and', ' ').split(' ')
  # end
    
  def gender_string=(gender_string)
    self.gender_array=gender_string.gsub(',', ' ').gsub('and', ' ').split(' ')
  end

  def orientation_string=(orientation_string)
    self.orientation_array=orientation_string.gsub(',', ' ').gsub('and', ' ').split(' ')
  end
  
  # Feature is any of the serialized column
  def self.calculated_info(feature)
    info_array = []
    self.scoped.each do |f|
      (info_array << f.send(feature)).flatten!
    end
    
    info_array.count_list_members
  end

end
