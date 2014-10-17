class Report < ActiveRecord::Base
  attr_accessible :user_name, :gender_hash, :orientation_hash
  serialize :gender_hash, Hash
  serialize :orientation_hash, Hash
  
  validates_presence_of :user_name
  
  def generate
    # ActiveRecord collection of users in our DB who have given demo info.
    # (These users are the people whom this report's Tweetee follows.)
    # friends = get_user_objects_for_report(self.user_name)
    friends=User.all
    
    genders_array = []
    friends.each do |f|
      (genders_array << f.gender_array).flatten!
    end
    
    orientations_array= []
    friends.each do |f|
      (orientations_array << f.orientation_array).flatten!
    end
    
    #
    calculated_gender_info = count_list_members(genders_array)
    # genders_array.each do |c|
    #   if calculated_gender_info.has_key?(c)
    #     calculated_gender_info[c] += 1
    #   else
    #     calculated_gender_info[c] = 1
    #   end
    # end

    calculated_orientation_info = count_list_members(orientations_array)
    # orientations_array.each do |c|
    #   if calculated_orientation_info.has_key?(c)
    #     calculated_orientation_info[c] += 1
    #   else
    #     calculated_orientation_info[c] = 1
    #   end
    # end

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
  def get_user_objects_for_report(tweeter)
    following_objects=[]
    following_ids=User.friends_ids_array(tweeter)   # s/b an instance method on report_object.user_name
    following_ids.each do |twitter_id|
      string_id=twitter_id.to_s
      user_object=User.find_by_uid(string_id)
      following_objects << user_object if user_object != nil
    end
    following_objects
  end
  
  # Returns an Array containing all the genders, orientations or abilities from a particular attribute of an Array of objects
  def extract_genders
    collection=[]
    self.each do |u|
      (collection << u.gender_array).flatten!
    end
    collection
  end
  
  # Returns an Array containing all the genders, orientations or abilities from a particular attribute of an Array of objects
  def extract_orientations
    collection=[]
    self.each do |u|
      (collection << u.orientation_array).flatten!
    end
    collection
  end
  
  # Returns an Array containing all the abilities from a abilities_arrays of an Array of objects
  # def extract_abilities
  #   collection=[]
  #   self.each do |u|
  #     (collection << u.abilities_array).flatten!
  #   end
  #   collection
  # end
  
  # Returns a Hash where the keys are the elements of the collection and the values are the number of occurences of each element
  def count_from_array
    collection_sums={}
    self.each do |c|
      if collection_sums.has_key?(c)
        collection_sums[c] += 1
      else
        collection_sums[c] = 1
      end
    end
    collection_sums
  end
  
end


# def generate
#   # ActiveRecord collection of users in our DB who have given demo info.
#   # (These users are the people whom this report's Tweetee follows.)
#   friends = get_user_objects_for_report(self.user_name)
#   genders_array = friends.extract_genders
#   orientations_array = friends.extract_orientations
#   calculated_gender_info = genders_array.count_from_array
#   calculated_orientation_info = orientations_array.count_from_array
#   self.update_attributes(gender_hash: calculated_gender_info, orientation_hash: calculated_orientation_info)
# end
