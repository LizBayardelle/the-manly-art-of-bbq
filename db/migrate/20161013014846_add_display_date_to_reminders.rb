class AddDisplayDateToReminders < ActiveRecord::Migration
  def change
      add_column :reminders, :display_date, :date
  end
end
