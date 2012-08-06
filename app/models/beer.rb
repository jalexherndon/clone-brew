class Beer < ActiveRecord::Base
  belongs_to  :brewery
  has_many    :recipes

  attr_accessible :description, :name, :brewery_id
  validates :name, :presence => true
  validates :brewery_id, :presence => true
end
