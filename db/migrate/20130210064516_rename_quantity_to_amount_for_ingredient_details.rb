class RenameQuantityToAmountForIngredientDetails < ActiveRecord::Migration
  def up
    rename_column :ingredient_details, :quantity, :amount
  end

  def down
    rename_column :ingredient_details, :amount, :quantity
  end
end
