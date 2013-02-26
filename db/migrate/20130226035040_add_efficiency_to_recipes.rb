class AddEfficiencyToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :efficiency, :integer
  end
end
