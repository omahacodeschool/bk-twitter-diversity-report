class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :gender_array
      t.string :orientation_array
      t.string :provider

      t.timestamps
    end
  end
end
