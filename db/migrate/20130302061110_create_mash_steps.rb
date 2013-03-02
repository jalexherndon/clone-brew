class CreateMashSteps < ActiveRecord::Migration
  def change
    create_table :mash_steps do |t|
      t.integer :recipe_id
      t.integer :step_type
      t.integer :temperature
      t.integer :time
      t.integer :mash_volume
      t.text :description

      t.timestamps
    end
  end
end
