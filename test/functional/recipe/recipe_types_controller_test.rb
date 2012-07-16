require 'test_helper'

class Recipe::RecipeTypesControllerTest < ActionController::TestCase
  setup do
    @recipe_recipe_type = recipe_recipe_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipe_recipe_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe_recipe_type" do
    assert_difference('Recipe::RecipeType.count') do
      post :create, recipe_recipe_type: { name: @recipe_recipe_type.name }
    end

    assert_redirected_to recipe_recipe_type_path(assigns(:recipe_recipe_type))
  end

  test "should show recipe_recipe_type" do
    get :show, id: @recipe_recipe_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recipe_recipe_type
    assert_response :success
  end

  test "should update recipe_recipe_type" do
    put :update, id: @recipe_recipe_type, recipe_recipe_type: { name: @recipe_recipe_type.name }
    assert_redirected_to recipe_recipe_type_path(assigns(:recipe_recipe_type))
  end

  test "should destroy recipe_recipe_type" do
    assert_difference('Recipe::RecipeType.count', -1) do
      delete :destroy, id: @recipe_recipe_type
    end

    assert_redirected_to recipe_recipe_types_path
  end
end
