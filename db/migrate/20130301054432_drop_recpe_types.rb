class DropRecpeTypes < ActiveRecord::Migration
  def change
    drop_table :recipe_types
  end
end
