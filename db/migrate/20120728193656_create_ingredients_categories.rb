class CreateIngredientsCategories < ActiveRecord::Migration
  def change
    create_table :ingredients_categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
