class Beer < ActiveRecord::Base
  belongs_to  :brewery
  has_many    :recipes, :class_name => "Recipe::Recipe"

  attr_accessible :description, :name, :brewery_id
  validates :name, :presence => true
  validates :brewery_id, :presence => true
end
