class Recipe < ActiveRecord::Base
  extend Queryable

  belongs_to  :beer
  belongs_to  :recipe_type
  belongs_to  :user

  has_many    :ingredient_details
  has_many    :ingredients, :through => :ingredient_details

  attr_accessible :directions,
                  :mash_temperature,
                  :boil_time,
                  :pre_boil_volume,
                  :boil_size,
                  :recipe_type_id,
                  :ingredient_ids,
                  :ingredient_details,
                  :beer_id,
                  :user,
                  :name,
                  :notes

  accepts_nested_attributes_for :ingredient_details

  validates_presence_of :name
  validates_presence_of :beer_id
  # validates :recipe_type_id, :presence => true

  def as_json(options={})
    super((options).merge({
      :only => [:id, :boil_time, :pre_boil_volume, :boil_size, :beer_id, :name, :notes],
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
