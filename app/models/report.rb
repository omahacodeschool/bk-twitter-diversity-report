class Report < ActiveRecord::Base
  attr_accessible :user_name, :gender_hash, :orientation_hash
  serialize :gender_hash, Hash
  serialize :orientation_hash, Hash
  
  validates_presence_of :user_name
  
  def generate
    # ActiveRecord collection of users in our DB who have given demo info.
    # (These users are the people whom this report's Tweetee follows.)
    friends = users_who_are_friends
     
    genders_array = []
    friends.each do |f|
      (genders_array << f.gender_array).flatten!
    end
    
    orientations_array= []
    friends.each do |f|
      (orientations_array << f.orientation_array).flatten!
    end
    
    calculated_gender_info = count_list_members(genders_array)
    
    calculated_orientation_info = count_list_members(orientations_array)
    
    self.update_attributes(gender_hash: calculated_gender_info, orientation_hash: calculated_orientation_info)
  end
  
  def count_list_members(list)
    counting_hash = {}
    list.each do |c|
      if counting_hash.has_key?(c)
        counting_hash[c] += 1
      else
        counting_hash[c] = 1
      end
    end
    counting_hash
  end
  
  # Returns an Array of User objects that tweeter is following
  # def get_user_objects_for_report(tweeter)
  #   following_ids=User.friends_ids_array(tweeter)
  #
  #   following_uids=following_ids.collect{ |i| i.to_s }
  #
  #   User.where(uid: following_uids)
  # end
  #
  # def percent_added_demogs
  #   following_ids=User.friends_ids_array(self.user_name)
  #   total_friends=following_ids.length
  #   following_uids=following_ids.collect{ |i| i.to_s }
  #   friends_in_db=User.where(uid: following_uids).length
  #   ((friends_in_db.to_f / total_friends.to_f)*100.0).round(2)
  # end
  
  # Array of ids who user is following
  def friends_ids
    User.friends_ids_array(self.user_name)
  end
  
  # Array of User object the user is following
  def users_who_are_friends
    friends_uids=friends_ids.collect{ |i| i.to_s }
    User.where(uid: friends_uids)
  end
  
  # Float that is percentage of the user's friends who are in users table
  def percent_friends_demoged
    total_friends=friends_ids.length
    friends_in_db=users_who_are_friends
    binding.pry
    ((friends_in_db.to_f / total_friends.to_f)*100.0).round(2)
  end
  
end
