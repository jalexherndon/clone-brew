require 'faker'

class UserBuilder

  class << self
    def user(data = {})
      @user_data = data
      self
    end

    def basic_user
      user.with_first_name
          .with_last_name
          .with_email
          .with_password
      self
    end

    def with_first_name(first_name = Faker::Name.first_name)
      @user_data[:first_name] = first_name
      self
    end

    def with_last_name(last_name = Faker::Name.last_name)
      @user_data[:last_name] = last_name
      self
    end

    def with_email(email = Faker::Internet.email)
      @user_data[:email] = email
      self
    end

    def with_password(password = 'Password')
      @user_data[:password] = password
      self
    end

    def build
      User.new @user_data
    end
  end

end