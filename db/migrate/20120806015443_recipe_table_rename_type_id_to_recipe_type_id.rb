class RecipeTableRenameTypeIdToRecipeTypeId < ActiveRecord::Migration
  def up
    rename_column :recipes, :type_id, :recipe_type_id
  end

  def down
    rename_column :recipes, :recipe_type_id, :type_id
  end
end
