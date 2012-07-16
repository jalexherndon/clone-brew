class Recipe::RecipeType < ActiveRecord::Base
  has_many :recipes

  attr_accessible :name
end
