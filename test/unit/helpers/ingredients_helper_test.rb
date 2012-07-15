require 'test_helper'

class IngredientsHelperTest < ActionView::TestCase
  test 'can set the category of an ingredient if it is in the CATEGORIES array' do
    ingredient = Ingredient.new :name=>'name'

    IngredientsHelper::CATEGORIES.each do |key, value|
      ingredient.category= value
      assert ingredient.category_is? value
    end
  end

  test 'can not set the category of an ingredient if it is not in the CATEGORIES array' do
    ingredient = Ingredient.new :name=>'name'
    bad_hash = {
      :a => 'a',
      :b => 'b',
      :c => 'c'
    }

    bad_hash.each do |key, value|
      ingredient.category= value
      assert ingredient.category_is? nil
    end
  end
end
