class Ingredients::Category < ActiveRecord::Base

  has_many :ingredients, :class_name => 'Ingredients::Ingredient'

  attr_accessible :description, :name
  validates :name, :presence => true
end
