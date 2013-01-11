class AddBoilTimeToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :boil_time, :integer
  end
end
