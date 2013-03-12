class IngredientDetail < ActiveRecord::Base
  extend Queryable

  CUPS = 0
  G = 1
  KG = 2
  LBS = 3
  OZ = 4
  PERCENT = 5
  PKG = 6

  UNITS = [
    CUPS,
    G,
    KG,
    LBS,
    OZ,
    PERCENT,
    PKG
  ]

  belongs_to :recipe
  belongs_to :ingredient

  attr_accessible :notes,
                  :amount,
                  :units,
                  :time,
                  :ingredient_id,
                  :recipe_id

  validates_presence_of :amount,
                        :ingredient_id,
                        :recipe_id,
                        :units

  validates :units, :inclusion => {:in => UNITS}

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
