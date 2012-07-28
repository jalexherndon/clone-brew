class Ingredients::Ingredient < ActiveRecord::Base

  belongs_to :category, :class_name => "Ingredients::Category"
  has_and_belongs_to_many :recipes, :join_table => "recipes_ingredients", :class_name => "Recipe::Recipe"

  attr_accessible :description, :name
  validates :name, :presence => true
end
