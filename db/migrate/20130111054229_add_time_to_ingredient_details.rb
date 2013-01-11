class AddTimeToIngredientDetails < ActiveRecord::Migration
  def change
    add_column :ingredient_details, :time, :integer
  end
end
