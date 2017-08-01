class AddFishToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :fish, :boolean
  end
end
