class AddDefaultValues < ActiveRecord::Migration
  def change
    change_column :users, :manpoints, :integer, default: 0
    change_column :jokes, :kids, :boolean, default: false
    change_column :jokes, :mixed, :boolean, default: false
    change_column :jokes, :approved, :boolean, default: false
    change_column :jokes, :rejected, :boolean, default: false
    change_column :jokes, :rank, :float, default: 0
  end
end
