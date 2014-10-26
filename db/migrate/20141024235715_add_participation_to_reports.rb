class AddParticipationToReports < ActiveRecord::Migration
  def change
    add_column :reports, :participation, :decimal
  end
end
