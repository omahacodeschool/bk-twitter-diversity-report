class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :gender_array
      t.integer, :age_array
      t.string :race_array

      t.timestamps
    end
  end
end
