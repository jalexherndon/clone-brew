class IngredientDetail < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  attr_accessible :notes,
                  :amount,
                  :units,
                  :time,
                  :ingredient_id,
                  :recipe_id

  validates_presence_of :ingredient_id
  validates_presence_of :recipe_id

  def as_json(options={})
    super((options).merge({
      :only => [:id, :notes, :amount, :units, :time, :ingredient_id, :recipe_id]
    }))
  end
end
