class ChangeUserTokenColumnName < ActiveRecord::Migration
  def change
      rename_column :users, :user_token, :token
  end
end
