class Recipe::Recipe < ActiveRecord::Base
  belongs_to              :beer
  belongs_to              :recipe_type
  has_and_belongs_to_many :ingredients, :join_table => "recipes_ingredients", :class_name => "Ingredient"

  attr_accessible :directions, :beer_attributes
end
