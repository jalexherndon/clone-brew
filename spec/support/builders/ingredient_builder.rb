require 'faker'

class IngredientBuilder

  class << self
    def ingredient(data = {})
      @ingredient_data = data
      self
    end

    def basic_ingredient
      ingredient.with_name
                .with_ingredient_category_id

      self
    end

    def with_name(name = Faker::Lorem.characters((1 + rand(20))))
      @ingredient_data[:name] = name
      self
    end

    def with_ingredient_category_id(ingredient_category_id = nil)
      if ingredient_category_id.nil?
        ingredient_category = IngredientCategory.limit(1).first
        ingredient_category_id = ingredient_category.id
      end
      @ingredient_data[:ingredient_category_id] = ingredient_category_id
      self
    end

    def build
      Ingredient.new @ingredient_data
    end
  end

end