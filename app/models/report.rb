class Report < ActiveRecord::Base
  attr_accessible :user_name, :gender_hash, :orientation_hash
  serialize :gender_hash, Hash
  serialize :orientation_hash, Hash
  
  def generate
    # ActiveRecord collection of users in our DB who have given demo info.
    # (These users are the people whom this report's Tweetee follows.)
    friends = get_user_objects_for_report
    
    # ...
    # calculated_gender_info  = ...
    
    self.update_attributes(gender_hash: calculated_gender_info, orientation_hash: calculated_orientation_info)
  end
  
  # Returns an Array of User objects that tweeter is following
  def get_user_objects_for_report
    following_objects=[]
    following_ids=User.friends_ids_array(tweeter)
    following_ids.each do |twitter_id|
      string_id=twitter_id.to_s
      user_object=User.find_by_uid(string_id)
      following_objects << user_object if user_object != nil
    end
    following_objects
  end
  
  # Returns an Array containing all the genders, orientations or abilities from a particular attribute of an Array of objects
  def array_from_user(following)
    collection=[]
    following.each do |u|
      (collection << u.gender_array).flatten!
    end
    collection
  end
  
  # Returns a Hash where the keys are the elements of the collection and the values are the number of occurences of each element
  def count_from_array(collection)
    collection_sums={}
    collection.each do |c|
      if collection_sums.has_key?(c)
        collection_sums[c] += 1
      else
        collection_sums[c] = 1
      end
    end
    collection_sums
  end
  
  def gender_array=(gender_array)
    self.gender_hash=gender_array.count_from_array
  end
  
  def orientation_array=(orientation_array)
    self.orientation_hash=orientation_array.count_from_array
  end
  
end
