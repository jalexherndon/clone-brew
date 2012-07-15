class Ingredient < ActiveRecord::Base
  include IngredientsHelper

  attr_accessible :description, :name, :category
  validates :name, :presence => true
end
