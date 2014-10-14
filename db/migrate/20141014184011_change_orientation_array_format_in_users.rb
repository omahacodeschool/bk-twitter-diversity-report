class ChangeOrientationArrayFormatInUsers < ActiveRecord::Migration
  def up
    change_column :users, :orientation_array, :text
  end

  def down
    change_column :users, :orientation_array, :string
  end
end
