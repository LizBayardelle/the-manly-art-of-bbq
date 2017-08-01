class RemoveDisplayDateReminders < ActiveRecord::Migration
  def change
      remove_column :reminders, :display_date
  end
end
