class AddBrewMethodToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :brew_method, :integer
  end
end
