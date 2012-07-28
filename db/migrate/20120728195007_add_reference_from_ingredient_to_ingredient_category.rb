class AddReferenceFromIngredientToIngredientCategory < ActiveRecord::Migration
  def change
    remove_column :ingredients_ingredients, :category
    add_column :ingredients_ingredients, :category_id, :integer
  end
end
