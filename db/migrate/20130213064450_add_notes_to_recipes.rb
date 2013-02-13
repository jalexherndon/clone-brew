class AddNotesToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :notes, :text
  end
end
