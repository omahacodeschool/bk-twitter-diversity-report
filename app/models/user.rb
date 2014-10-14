class User < ActiveRecord::Base
  attr_accessible :gender_array, :name, :orientation_array, :provider
  # has_many :reports
  serialize :gender_array, Array
  serialize :orientation_array, Array
  
  # client = Twitter::REST::Client.new do |config|
  #   config.consumer_key        = "lR6cZFq2LxeGb5PEJd3AkHP4e"
  #   config.consumer_secret     = "wuwmK2oXoLkmIOnDpr2rhImZrXi54yUQwYpJP8xhRbdxQGAOn9"
  #   config.access_token        = "2288559728-oY0jrZ99KfzaKxKrqFq7EICOXmecy0YQY9lnbBy"
  #   config.access_token_secret = "52bJo8FkbbFGq74Y0btwM1qSYu7MxAymi7OxwteWd3jFH"
  # end
  #
  # binding.pry
  
  def string_to_array(string)
    string.split(" ")
  end
  
end
