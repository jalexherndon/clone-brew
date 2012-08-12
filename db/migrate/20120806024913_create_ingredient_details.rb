class CreateIngredientDetails < ActiveRecord::Migration
  def change
    create_table :ingredient_details do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
      t.float :quantity
      t.string :units
      t.text :description

      t.timestamps
    end
  end
end
