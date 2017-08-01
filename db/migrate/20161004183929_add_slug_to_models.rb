class AddSlugToModels < ActiveRecord::Migration
  def change
      add_column :jokes, :slug, :string
      add_index :jokes, :slug, unique: true
      add_column :recipes, :slug, :string
      add_index :recipes, :slug, unique: true
      add_column :reminders, :slug, :string
      add_index :reminders, :slug, unique: true
  end
end
