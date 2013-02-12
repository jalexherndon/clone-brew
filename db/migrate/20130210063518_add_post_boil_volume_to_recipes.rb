class AddPostBoilVolumeToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :post_boil_volume, :integer
  end
end
