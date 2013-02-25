class IngredientDetail < ActiveRecord::Base
  extend Queryable

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
      :only => [:id, :notes, :amount, :units, :time, :recipe_id],
      :include => {
        :ingredient => {
          :only => [:id, :name],
          :include => {
            :ingredient_category => {
              :only => [:id, :name]
            }
          }
        }
      }
    }))
  end
end
