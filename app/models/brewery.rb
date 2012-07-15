class Brewery < ActiveRecord::Base
  has_many :beers
  attr_accessible :city, :description, :name, :state
  validate :name, :presence => true
end
