class CreateOccasions < ActiveRecord::Migration
  def change
    create_table :occasions do |t|
      t.string :name
      t.date :date
      t.boolean :reminder, default: false
      t.string :repeating
      t.boolean :approved
      t.boolean :gift, default: false
      t.boolean :gift_help, default: false
      t.string :occasion_type, default: "Other"
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :occasions, :user_id
  end
end
