class BetaUser < ActiveRecord::Base
  attr_accessible :beta_interest, :email, :first_name, :last_name
end
