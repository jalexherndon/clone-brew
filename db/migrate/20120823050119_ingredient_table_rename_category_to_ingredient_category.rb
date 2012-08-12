class IngredientTableRenameCategoryToIngredientCategory < ActiveRecord::Migration
  def up
    rename_column :ingredients, :category_id, :ingredient_category_id
  end

  def down
    rename_column :ingredients, :ingredient_category_id, :category_id
  end
end
