class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.text :manrule
      t.integer :rankpoints, default: 0
      t.boolean :approved, default: false
      t.boolean :rejected, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
