class Report < ActiveRecord::Base
  attr_accessible :user_name, :gender_hash, :orientation_hash, :participation
  serialize :gender_hash, Hash
  serialize :orientation_hash, Hash
  
  validates_presence_of :user_name
  
  def generate
    # Array of ids of twitter friends
    friends_ids_list = friends_ids
    
    # Array of User objects who are friends
    friends_who_particpate = users_who_are_friends(friends_ids_list)
     
    genders_array = []
    friends_who_particpate.each do |f|
      (genders_array << f.gender_array).flatten!
    end
    
    orientations_array= []
    friends_who_particpate.each do |f|
      (orientations_array << f.orientation_array).flatten!
    end
    
    calculated_gender_info = count_list_members(genders_array)
    
    calculated_orientation_info = count_list_members(orientations_array)
    
    calculated_participation = percent_participation(friends_who_particpate.length, friends_ids_list.length)
    
    self.update_attributes(
      gender_hash: calculated_gender_info,
      orientation_hash: calculated_orientation_info,
      participation: calculated_participation
      )
  end
  
  # Returns a Hash from an Array of String elements
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
  
  # Returns Array of ids who user is following
  def friends_ids
    User.friends_ids_array(self.user_name)
  end
  
  # Returns Array of User objects the user is following
  def users_who_are_friends(list_of_ids)
    friends_uids=list_of_ids.collect{ |i| i.to_s }
    User.where(uid: friends_uids)
  end
  
  # Returns a Float that is the percentage of the user's friends who are in users table
  def percent_participation(users, friends)
    ((users.to_f / friends.to_f)*100.0).round(2)
  end
  
end
