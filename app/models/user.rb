class User < ActiveRecord::Base
  attr_accessible :gender_array, :name, :orientation_array, :provider
  # has_many :reports
  serialize :gender_array, Array
  serialize :orientation_array, Array
  
  def string_to_array(string)
    string.split(" ")
  end
  
end
