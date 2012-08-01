class Recipe::Recipe < ActiveRecord::Base
  belongs_to              :beer
  belongs_to              :type, :class_name => "Recipe::Type"
  has_and_belongs_to_many :ingredients, :join_table => "recipes_ingredients", :class_name => "Ingredients::Ingredient"

  attr_accessible :directions, :beer_id, :type_id, :ingredient_ids
  validates :beer_id, :presence => true
  validates :type_id, :presence => true
end
