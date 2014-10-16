class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :user_name
      t.text :gender_has
      t.text :orientation_hash

      t.timestamps
    end
  end
end
