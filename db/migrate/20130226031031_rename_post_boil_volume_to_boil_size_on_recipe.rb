class RenamePostBoilVolumeToBoilSizeOnRecipe < ActiveRecord::Migration
  def up
    rename_column :recipes, :post_boil_volume, :boil_size
  end

  def down
    rename_column :recipes, :boil_size, :post_boil_volume
  end
end
