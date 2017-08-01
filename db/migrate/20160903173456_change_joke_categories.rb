class ChangeJokeCategories < ActiveRecord::Migration
  def change
    add_column :jokes, :men, :boolean, default: false
    add_column :jokes, :comeback, :boolean, default: false
  end
end
