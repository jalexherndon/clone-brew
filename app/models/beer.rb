class Beer < ActiveRecord::Base
  belongs_to  :brewery
  has_many    :recipes

  attr_accessible :description, :name
  validates :name, :presence => true
end
