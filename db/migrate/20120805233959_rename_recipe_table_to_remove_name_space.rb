class RenameRecipeTableToRemoveNameSpace < ActiveRecord::Migration
  def up
    rename_table :recipe_recipes, :recipes
  end

  def down
    rename_table :recipes, :recipe_recipes
  end
end
