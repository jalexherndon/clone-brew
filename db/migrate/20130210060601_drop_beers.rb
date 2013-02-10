class DropBeers < ActiveRecord::Migration
  def up
    drop_table :beers
  end
end
