class Brewery < ActiveRecord::Base
  attr_accessible :city, :description, :name, :state
  validate :name, :presence => true
end
