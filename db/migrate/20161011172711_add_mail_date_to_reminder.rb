class AddMailDateToReminder < ActiveRecord::Migration
  def change
      add_column :reminders, :mail_date, :date
  end
end
