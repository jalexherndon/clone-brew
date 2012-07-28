class MoveIngredientIntoIngredientsNameSpace < ActiveRecord::Migration
  def up
    rename_table :ingredients, :ingredients_ingredients
  end

  def down
    rename_table :ingredients_ingredients, :ingredients
  end
end
