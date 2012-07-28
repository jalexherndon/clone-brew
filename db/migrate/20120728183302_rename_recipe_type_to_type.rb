class RenameRecipeTypeToType < ActiveRecord::Migration
  def up
    rename_table :recipe_recipe_types, :recipe_types
    rename_column :recipe_recipes, :recipe_type_id, :type_id
  end

  def down
    rename_column :recipe_recipes, :type_id, :recipe_type_id
    rename_table :recipe_types, :recipe_recipe_types
  end
end
