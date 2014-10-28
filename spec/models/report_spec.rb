require 'rails_helper'

RSpec.describe Report, :type => :model do
  it "#count_list_members should count string elements in a list" do
    list = ["one", "two", "two", "three", "three", "three", "four", "four", "four", "four"]
    expect(count_list_members(list)).to eq({"one" => 1, "two" => 2, "three" => 3, "four" => 4})
  end
  
  it "#percent_participation should calculate the users who are friends" do
    users = 17
    friends = 89
    expect(percent_participation(users, friends)).to eql(19.10)
  end
  
end
