class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_time
      t.text :recurring
      t.boolean :reminder
      t.boolean :gift
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
