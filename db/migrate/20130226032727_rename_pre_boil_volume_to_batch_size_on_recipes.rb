class RenamePreBoilVolumeToBatchSizeOnRecipes < ActiveRecord::Migration
  def up
    rename_column :recipes, :pre_boil_volume, :batch_size
  end

  def down
    rename_column :recipes, :batch_size, :pre_boil_volume
  end
end
