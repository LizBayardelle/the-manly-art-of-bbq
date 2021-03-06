class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.text :suggestion
      t.string :page
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
