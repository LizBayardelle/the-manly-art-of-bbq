class FixJokeType < ActiveRecord::Migration
  def change
    remove_column :jokes, :men
    remove_column :jokes, :mixed
    remove_column :jokes, :kids
    remove_column :jokes, :comeback
    add_column :jokes, :joke_type, :string
  end
end
