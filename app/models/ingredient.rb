class Ingredient < ActiveRecord::Base
  include IngredientsHelper

  has_and_belongs_to_many :recipes, :join_table => "recipes_ingredients", :class_name => "Recipe::Recipe"

  attr_accessible :description, :name, :category
  validates :name, :presence => true
end
