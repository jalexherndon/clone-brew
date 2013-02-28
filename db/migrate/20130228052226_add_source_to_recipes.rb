class AddSourceToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :source, :text
  end
end
