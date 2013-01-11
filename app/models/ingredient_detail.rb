class IngredientDetail < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  attr_accessible :description,
                  :quantity,
                  :units,
                  :time,
                  :ingredient_id,
                  :recipe_id

  validates :ingredient_id, :presence => true
  validates :recipe_id, :presence => true
end
