class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :instructions
      t.boolean :chicken
      t.boolean :beef
      t.boolean :other_meat
      t.boolean :veggies
      t.boolean :approved, default: false
      t.boolean :rejected, default: false
      t.integer :rankpoints, default: 0
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :recipes, :user_id
  end
end
