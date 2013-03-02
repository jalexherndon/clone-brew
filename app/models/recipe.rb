class Recipe < ActiveRecord::Base
  extend Queryable

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

  attr_accessible :directions,
                  :mash_temperature,
                  :boil_time,
                  :batch_size,
                  :boil_size,
                  :brew_method,
                  :ingredient_ids,
                  :ingredient_details,
                  :beer_id,
                  :user,
                  :name,
                  :notes,
                  :efficiency,
                  :source

  accepts_nested_attributes_for :ingredient_details

  validates_presence_of :name
  validates_presence_of :beer_id
  validates_presence_of :brew_method
  validates_presence_of :efficiency
  
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
