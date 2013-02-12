class RenameDescriptionToNotesForIngredientDetails < ActiveRecord::Migration
  def up
    rename_column :ingredient_details, :description, :notes
  end

  def down
    rename_column :ingredient_details, :notes, :description
  end
end
