class ChangeUnitsFromStringToIntegerOnIngredientDetails < ActiveRecord::Migration
  def up
    remove_column :ingredient_details, :units
    add_column :ingredient_details, :units, :integer
  end

  def down
    remove_column :ingredient_details, :units
    add_column :ingredient_details, :units, :string
  end
end
