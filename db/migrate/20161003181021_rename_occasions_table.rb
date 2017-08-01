class RenameOccasionsTable < ActiveRecord::Migration
  def change
    rename_table :occasions, :reminders
  end
end
