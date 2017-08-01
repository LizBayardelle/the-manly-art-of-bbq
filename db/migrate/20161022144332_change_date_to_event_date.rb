class ChangeDateToEventDate < ActiveRecord::Migration
  def change
  	rename_column :reminders, :date, :event_date
  end
end
