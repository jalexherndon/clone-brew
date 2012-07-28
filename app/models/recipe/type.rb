class Recipe::Type < ActiveRecord::Base
  has_many :recipes, :class_name => "Recipe::Recipe"

  attr_accessible :name
  validates :name, :presence => true
end