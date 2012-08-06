class Recipe < ActiveRecord::Base
  belongs_to              :beer
  belongs_to              :recipe_type
  has_and_belongs_to_many :ingredients, :join_table => "recipes_ingredients"

  attr_accessible :directions, :beer_id, :recipe_type_id, :ingredient_ids
  validates :beer_id, :presence => true
  validates :recipe_type_id, :presence => true
end
