class CreateBreweries < ActiveRecord::Migration
  def change
    create_table :breweries do |t|
      t.string :name
      t.text :description
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
