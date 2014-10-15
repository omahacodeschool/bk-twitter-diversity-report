class ChangeUserSecretColumnName < ActiveRecord::Migration
  def change
      rename_column :users, :user_secret, :secret
  end
end
