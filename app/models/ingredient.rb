class Ingredient < ActiveRecord::Base

  belongs_to  :category, :class_name => 'IngredientCategory'
  has_many    :ingredient_details
  has_many    :recipes, :through => :ingredient_details

  #has_and_belongs_to_many :recipes, :join_table => "recipes_ingredients"

  accepts_nested_attributes_for :ingredient_details
  attr_accessible :description, :name, :category_id, :ingredient_detail_ids
  validates :name, :presence => true
  validates :category_id, :presence => true
end
