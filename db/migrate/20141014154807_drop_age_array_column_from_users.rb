class DropAgeArrayColumnFromUsers < ActiveRecord::Migration
  def up
    add_column(:users, :ages_array, :string)
  end

  def down
    remove_column(:users, :age_array)
  end
end
