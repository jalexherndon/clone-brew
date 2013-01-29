class AddParentIngredientCategoryIdToIngredientCategory < ActiveRecord::Migration
  def change
    add_column :ingredient_categories, :parent_ingredient_category_id, :integer
  end
end
