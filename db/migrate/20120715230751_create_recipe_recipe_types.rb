class CreateRecipeRecipeTypes < ActiveRecord::Migration
  def change
    create_table :recipe_recipe_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
