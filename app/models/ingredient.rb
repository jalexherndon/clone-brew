class Ingredient < ActiveRecord::Base

  belongs_to :category, :class_name => 'IngredientCategory'
  has_and_belongs_to_many :recipes, :join_table => "recipes_ingredients"

  attr_accessible :description, :name, :category_id
  validates :name, :presence => true
  validates :category_id, :presence => true
end
