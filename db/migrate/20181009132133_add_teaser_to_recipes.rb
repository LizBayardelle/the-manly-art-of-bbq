class AddTeaserToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :teaser, :string
  end
end
