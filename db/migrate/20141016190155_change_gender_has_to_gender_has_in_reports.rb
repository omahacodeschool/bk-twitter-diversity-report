class ChangeGenderHasToGenderHasInReports < ActiveRecord::Migration
  def change
    rename_column :reports, :gender_has, :gender_hash
  end
end
