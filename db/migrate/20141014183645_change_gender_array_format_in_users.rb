class ChangeGenderArrayFormatInUsers < ActiveRecord::Migration
  def up
    change_column :users, :gender_array, :text
  end

  def down
    change_column :users, :gender_array, :string
  end
end
