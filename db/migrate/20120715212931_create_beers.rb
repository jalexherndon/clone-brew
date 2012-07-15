class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.text :description
      t.references :brewery

      t.timestamps
    end
    add_index :beers, :brewery_id
  end
end
