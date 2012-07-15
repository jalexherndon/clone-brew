class Beer < ActiveRecord::Base
  belongs_to :brewery
  attr_accessible :description, :name
end
