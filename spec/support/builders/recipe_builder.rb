require 'faker'

class RecipeBuilder

  class << self
    def recipe(data = {})
      @recipe_data = data
      self
    end

    def basic_recipe
      recipe.with_name
            .with_beer_id
            .with_brew_method
            .with_efficiency
            .with_user

      self
    end

    def with_name(name = Faker::Lorem.characters(1 + rand(59)))
      @recipe_data[:name] = name
      self
    end

    def with_beer_id(id = Faker::Lorem.characters(8))
      @recipe_data[:beer_id] = id
      self
    end

    def with_brew_method(method = Recipe::ALL_GRAIN)
      @recipe_data[:brew_method] = method
      self
    end

    def with_efficiency(efficiency = (60 + rand(40)))
      @recipe_data[:efficiency] = efficiency
      self
    end

    def with_user(user = nil)
      if user.nil?
        user = UserBuilder.basic_user.build
        user.save!
      end

      @recipe_data[:user] = user
      self
    end

    def build
      Recipe.new @recipe_data
    end
  end

end