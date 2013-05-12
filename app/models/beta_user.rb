class BetaUser < ActiveRecord::Base
  attr_accessible :beta_interest, :email, :first_name, :last_name
  validates :email,
            :uniqueness => true,
            :allow_nil => false

  before_validation do
    puts "before_validation"
    self.email = self.email.downcase
  end
end
