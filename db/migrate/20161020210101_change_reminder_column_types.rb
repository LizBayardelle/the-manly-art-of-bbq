class ChangeReminderColumnTypes < ActiveRecord::Migration
  def change
      change_column :reminders, :date, :datetime
      change_column :reminders, :mail_date, :datetime
  end
end
