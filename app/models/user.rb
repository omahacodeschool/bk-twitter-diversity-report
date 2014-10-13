class User < ActiveRecord::Base
  attr_accessible :age_array, :gender_array, :name, :race_array
end
