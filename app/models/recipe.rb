class Recipe < ActiveRecord::Base
  extend Queryable

  # Keep these in alphabetical order from 0 up
  ALL_GRAIN = 0
  EXTRACT = 1
  PARTIAL_MASH = 2

  BREW_METHODS = [
    ALL_GRAIN,
    EXTRACT,
    PARTIAL_MASH
  ]

  belongs_to  :beer
  belongs_to  :user

  has_many    :ingredient_details
  has_many    :ingredients, :through => :ingredient_details
  has_many    :mash_steps

  attr_accessible :batch_size,
                  :beer_id,
                  :boil_size,
                  :boil_time,
                  :brew_method,
                  :directions,
                  :efficiency,
                  :ingredient_details,
                  :ingredient_ids,
                  :mash_steps,
                  :mash_temperature,
                  :name,
                  :notes,
                  :source,
                  :user

  accepts_nested_attributes_for :ingredient_details
  accepts_nested_attributes_for :mash_steps

  validates_presence_of :name,
                        :beer_id,
                        :brew_method,
                        :efficiency,
                        :user

  validates :brew_method, :inclusion => {:in => BREW_METHODS}

  def as_json(options={})
    super((options).merge({
      :only => [:id, :batch_size, :beer_id, :boil_size, :boil_time, :brew_method, :efficiency, :name, :notes, :source],
      :include => [{
        :ingredient_details => {
          :only => [:id, :amount, :notes, :time, :units],
          :include => {
            :ingredient => {
              :only => [:id, :name],
              :include => {
                :ingredient_category => {:only => [:id, :name]}
              }
            }
          }
        }
      },{
        :user => {:only => [:id, :email, :first_name, :last_name]}
      }]
    }))
  end
end
