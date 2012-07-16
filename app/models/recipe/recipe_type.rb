class Recipe::RecipeType < ActiveRecord::Base
  has_many :recipes, :class_name => "Recipe"

  attr_accessible :name
end
