class AddRankToJokes < ActiveRecord::Migration
  def change
    add_column :jokes, :rank, :float
  end
end
