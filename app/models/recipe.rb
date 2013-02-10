class Recipe < ActiveRecord::Base
  belongs_to  :beer
  belongs_to  :recipe_type
  has_many    :ingredient_details
  has_many    :ingredients, :through => :ingredient_details

  attr_accessible :directions,
                  :mash_temperature,
                  :boil_time,
                  :beer_id,
                  :recipe_type_id,
                  :ingredient_ids,
                  :ingredient_detail_ids
                  
  accepts_nested_attributes_for :ingredient_details, :allow_destroy => true

  validates :beer_id, :presence => true
  # validates :recipe_type_id, :presence => true

  def display_name
    "#{beer.name}:  #{recipe_type.name}"
  end
end
