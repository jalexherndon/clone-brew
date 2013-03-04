require 'spec_helper'

describe RecipesController do
  login_user

  before(:each) do
    @recipe = RecipeBuilder.basic_recipe
                           .with_user(subject.current_user)
                           .build
    @recipe.save!
  end

  it 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipes)
  end

  it 'should create recipe' do
    assert_difference('Recipe.count') do
      response = post :create, recipe: {
        :name => @recipe.name,
        :beer_id => @recipe.beer_id,
        :brew_method => @recipe.brew_method,
        :efficiency => @recipe.efficiency
      }
    end

    assert_response_equals_recipe response, @recipe
  end

  it 'should show recipe' do
    response = get :show, id: @recipe

    assert_response :success
    assert_response_equals_recipe response, @recipe
  end

  describe 'PUT to recipe/:id' do
    it 'should update recipe' do
      orig_recipe = Recipe.find(@recipe)

      post_data = orig_recipe.attributes.symbolize_keys
      post_data[:name] = Faker::Lorem.characters(10 + rand(60))
      post_data[:efficiency] = 1 + rand(80)

      put :update, id: orig_recipe.id, recipe: post_data

      assert_response :success

      updated_recipe = Recipe.find(orig_recipe.id)
      assert_equal post_data[:name], updated_recipe.name
      assert_equal post_data[:efficiency], updated_recipe.efficiency
    end

    it 'should ignore protected attributes' do
      recipe = Recipe.find(@recipe)

      post_data = recipe.attributes
      protected_attr = "created_at"
      original = post_data[protected_attr]
      post_data[protected_attr] = "New date"

      response = put :update, id: recipe.id, recipe: post_data

      assert_response :success
      assert_equal original, Recipe.find(@recipe.id).attributes[protected_attr]
    end

    it 'should respond with updated recipe json' do
      recipe = Recipe.find(@recipe)

      post_data = recipe.attributes
      post_data["name"] = Faker::Lorem.characters(rand(40))

      response = put :update, id: recipe.id, recipe: post_data

      assert_response :success
      assert_response_equals_recipe response, post_data
    end
  end

  it 'should destroy recipe' do
    assert_difference('Recipe.count', -1) do
      delete :destroy, id: @recipe
    end

    assert_response :no_content
  end

  def assert_response_equals_recipe(response, recipe)
    unless recipe.is_a? Hash
      recipe = recipe.attributes
    end

    json_recipe = JSON.parse(response.body)
    assert_not_nil json_recipe

    assert_equal recipe['name'], json_recipe['name']
    assert_equal recipe['beer_id'], json_recipe['beer_id']
    assert_equal recipe['brew_method'], json_recipe['brew_method']
    assert_equal recipe['efficiency'], json_recipe['efficiency']
  end
end
