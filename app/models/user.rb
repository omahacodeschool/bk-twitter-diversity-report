class User < ActiveRecord::Base
  attr_accessible :gender_array, :name, :orientation_array, :provider
end
