require 'rails_helper'
require 'core'

RSpec.describe Array, :type => :model do
  it "#count_list_members should count string elements in a list" do
    list = ["one", "two", "two", "three", "three", "three", "four", "four", "four", "four"]
    expect(list.count_list_members).to eq({"one" => 1, "two" => 2, "three" => 3, "four" => 4})
  end
end
