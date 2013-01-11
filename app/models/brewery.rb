class Brewery < ActiveRecord::Base
  has_many :beers, :class_name => "Beer"

  attr_accessible :city,
                  :description,
                  :name,
                  :state

  validates :name, :presence => true
end
