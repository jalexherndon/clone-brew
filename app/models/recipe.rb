class Recipe < ActiveRecord::Base
  belongs_to  :beer
  belongs_to  :recipe_type
  belongs_to  :user

  has_many    :ingredient_details
  has_many    :ingredients, :through => :ingredient_details

  attr_accessible :directions,
                  :mash_temperature,
                  :boil_time,
                  :pre_boil_volume,
                  :post_boil_volume,
                  :beer_id,
                  :recipe_type_id,
                  :ingredient_ids,
                  :ingredient_details,
                  :user

  accepts_nested_attributes_for :ingredient_details

  validates_presence_of :beer_id
  # validates :recipe_type_id, :presence => true

  def as_json(options={})
    super((options).merge({
      :only => [:id, :boil_time, :pre_boil_volume, :post_boil_volume, :beer_id],
      :include => [{
        :ingredient_details => {
          :only => [:id, :amount, :notes, :time, :units],
          :include => {
            :ingredient => {:only => [:id, :name]}
          }
        }
      },{
        :user => {:only => [:id, :email, :first_name, :last_name]}
      }]
    }))
  end
end
