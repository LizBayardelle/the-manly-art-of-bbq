class FixEventModel < ActiveRecord::Migration
  def change
  	rename_column :events, :start_time, :event_date
  end
end
