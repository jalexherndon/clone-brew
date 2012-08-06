class MoveIngredientsCategoryOutOfIngredientsNameSpace < ActiveRecord::Migration
  def up
    rename_table :ingredients_categories, :ingredient_categories
  end

  def down
    rename_table :ingredient_categories, :ingredients_categories
  end
end
