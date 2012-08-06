class RecipeType < ActiveRecord::Base
  has_many :recipes

  attr_accessible :name
  validates :name, :presence => true
end
