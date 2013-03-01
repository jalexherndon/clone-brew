class RemoveRecpeTypeFromRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :recipe_type_id
  end
end
