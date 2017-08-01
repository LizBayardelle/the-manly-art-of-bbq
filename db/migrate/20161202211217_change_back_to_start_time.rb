class ChangeBackToStartTime < ActiveRecord::Migration
  def change
  	rename_column :events, :event_date, :start_time
  end
end
