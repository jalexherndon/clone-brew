class CreateRecipeRecipes < ActiveRecord::Migration
  def change
    create_table :recipe_recipes do |t|
      t.references :beer
      t.references :recipe_type
      t.text :directions

      t.timestamps
    end
    add_index :recipe_recipes, :beer_id
    add_index :recipe_recipes, :recipe_type_id

    # Create the join table for recipes and ingredients
    create_table :recipes_ingredients, :id => false do |t|
      t.references :recipe, :ingredient
    end
    add_index :recipes_ingredients, [:recipe_id, :ingredient_id]
  end
end
