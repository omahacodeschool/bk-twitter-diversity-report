class Report < ActiveRecord::Base
  attr_accessible :user_name, :gender_hash, :orientation_hash, :participation
  serialize :gender_hash, Hash
  serialize :orientation_hash, Hash
  
  validates_presence_of :user_name

  def generate
    # Array of ids of twitter friends
    # People the Reportee follows on Twitter.
    friends_ids_list = $client.friend_ids(self.user_name).attrs[:ids].collect{ |i| i.to_s }
    
    # Array of User objects who are friends
    # People the Reportee follows on Twitter WHO ARE IN OUR DEMOS DATABASE.
    friends_who_particpate = User.where(uid: friends_ids_list)
    
    # BUILD ALL THE STAT HASHES
    self.gender_hash = friends_who_particpate.calculated_info(:gender_array)
    self.orientation_hash = friends_who_particpate.calculated_info(:orientation_array)
    
    self.participation = percent_participation(friends_who_particpate.length, friends_ids_list.length)
    
    self.save
  end
  
  private
  
  # Returns a Float that is the percentage of the user's friends who are in users table
  def percent_participation(users, friends)
    ((users.to_f / friends.to_f)*100.0).round(2)
  end
  
end