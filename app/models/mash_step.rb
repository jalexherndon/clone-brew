class MashStep < ActiveRecord::Base
  extend Queryable

  # Keep in alphabetical order from 0 up
  DECOCTION = 0
  FLY_SPARGE = 1
  INFUSION = 2
  SPARGE = 3
  TEMPERATURE = 4

  STEP_TYPES = [
    DECOCTION,
    FLY_SPARGE,
    INFUSION,
    SPARGE,
    TEMPERATURE
  ]

  belongs_to      :recipe

  attr_accessible :description,
                  :mash_volume,
                  :recipe_id,
                  :step_type,
                  :temperature,
                  :time

  validates_presence_of :recipe_id,
                        :mash_volume,
                        :step_type,
                        :temperature,
                        :time

  validates :step_type, :inclusion => {:in => STEP_TYPES}

end
