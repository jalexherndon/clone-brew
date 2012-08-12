class IngredientDetail < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  attr_accessible :description, :ingredient_id, :quantity, :recipe_id, :units

  validates :ingredient_id, :presence => true
  validates :recipe_id, :presence => true
end
