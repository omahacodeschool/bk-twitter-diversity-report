class AddUserSecretToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_secret, :string
  end
end
