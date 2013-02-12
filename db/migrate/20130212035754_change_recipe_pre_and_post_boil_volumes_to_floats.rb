class ChangeRecipePreAndPostBoilVolumesToFloats < ActiveRecord::Migration
  def up
    change_column :recipes, :pre_boil_volume, :float
    change_column :recipes, :post_boil_volume, :float
  end

  def down
    change_column :recipes, :pre_boil_volume, :integer
    change_column :recipes, :post_boil_volume, :integer
  end
end
