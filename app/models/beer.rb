class Beer < ActiveRecord::Base
  belongs_to  :brewery
  has_many    :recipes, :class_name => "Recipe::Recipe"

  attr_accessible :description, :name
  validates :name, :presence => true
end
