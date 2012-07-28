require 'test_helper'

class Recipe::RecipesControllerTest < ActionController::TestCase
  setup do
    @recipe_recipe = recipe_recipes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipe_recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe_recipe" do
    assert_difference('Recipe::Recipe.count') do
      post :create, recipe_recipe: { beer_id: @recipe_recipe.beer.id, directions: @recipe_recipe.directions }
    end

    assert_redirected_to recipe_recipe_path(assigns(:recipe_recipe))
  end

  test "should show recipe_recipe" do
    get :show, id: @recipe_recipe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recipe_recipe
    assert_response :success
  end

  test "should update recipe_recipe" do
    put :update, id: @recipe_recipe, recipe_recipe: { directions: @recipe_recipe.directions }
    assert_redirected_to recipe_recipe_path(assigns(:recipe_recipe))
  end

  test "should destroy recipe_recipe" do
    assert_difference('Recipe::Recipe.count', -1) do
      delete :destroy, id: @recipe_recipe
    end

    assert_redirected_to recipe_recipes_path
  end
end
