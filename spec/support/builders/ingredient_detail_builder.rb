require 'faker'

class IngredientDetailBuilder

  class << self
    def ingredient_detail(data = {})
      @ingredient_detail_data = data
      self
    end

    def basic_ingredient_detail
      ingredient_detail.with_ingredient_id
                       .with_recipe_id
                       .with_amount
                       .with_units

      self
    end

    def with_ingredient_id(ingredient_id = nil)
      if ingredient_id.nil?
        ingredient_id = Ingredient.first.id
      end

      @ingredient_detail_data[:ingredient_id] = ingredient_id
      self
    end

    def with_recipe_id(recipe_id = nil)
      if recipe_id.nil?
        recipe = RecipeBuilder.basic_recipe.build
        recipe.save!
        recipe_id = recipe.id
      end

      @ingredient_detail_data[:recipe_id] = recipe_id
      self
    end

    def with_amount(amount = rand(100))
      @ingredient_detail_data[:amount] = amount
      self
    end

    def with_units(units = IngredientDetail::OZ)
      @ingredient_detail_data[:units] = units
    end

    def build
      IngredientDetail.new @ingredient_detail_data
    end
  end

end