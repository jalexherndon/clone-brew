class AddMashTemperatureToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :mash_temperature, :integer
  end
end
