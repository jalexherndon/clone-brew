class AddPreBoilVolumeToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :pre_boil_volume, :integer
  end
end
