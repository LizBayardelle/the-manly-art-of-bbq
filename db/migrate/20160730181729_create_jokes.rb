class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.string :title
      t.text :body
      t.boolean :kids
      t.boolean :mixed
      t.boolean :approved
      t.boolean :rejected
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :jokes, :user_id
  end
end
