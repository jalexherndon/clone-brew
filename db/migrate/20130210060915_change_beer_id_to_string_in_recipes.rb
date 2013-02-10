class ChangeBeerIdToStringInRecipes < ActiveRecord::Migration
  def up
    change_column :recipes, :beer_id, :string
  end

  def down
    change_column :recipes, :beer_id, :integer
  end
end
