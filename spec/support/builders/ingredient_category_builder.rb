require 'faker'

class IngredientCategoryBuilder

  class << self
    def ingredient_category(data = {})
      @ingredient_category_data = data
      self
    end

    def basic_ingredient_category
      ingredient_category.with_name
      self
    end

    def with_name(name = Faker::Lorem.characters(1 + rand(59)))
      @ingredient_category_data[:name] = name
      self
    end

    def build
      IngredientCategory.new @ingredient_category_data
    end
  end

end