require 'faker'

class MashStepBuilder

  class << self
    def mash_step(data = {})
      @mash_step_data = data
      self
    end

    def basic_mash_step
      mash_step.with_recipe_id
               .with_mash_volume
               .with_step_type
               .with_temperature
               .with_time

      self
    end

    def with_recipe_id(recipe_id = nil)
      unless recipe_id
        recipe = RecipeBuilder.basic_recipe.build
        recipe.save!
        recipe_id = recipe.id
      end

      @mash_step_data[:recipe_id] = recipe_id
      self
    end

    def with_mash_volume(mash_volume = rand(5))
      @mash_step_data[:mash_volume] = mash_volume
      self
    end

    def with_step_type(step_type = MashStep::DECOCTION)
      @mash_step_data[:step_type] = step_type
      self
    end

    def with_temperature(temperature = (50 + rand(150)))
      @mash_step_data[:temperature] = temperature
      self
    end

    def with_time(time = rand(120))
      @mash_step_data[:time] = time
      self
    end

    def build
      MashStep.new @mash_step_data
    end
  end

end