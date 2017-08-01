class CreateManTests < ActiveRecord::Migration
  def change
    create_table :man_tests do |t|
      t.integer :score
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
