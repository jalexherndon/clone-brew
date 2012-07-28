require 'test_helper'

class Ingredients::IngredientsControllerTest < ActionController::TestCase
  setup do
    @ingredients_ingredient = ingredients_ingredients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredients_ingredients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ingredients_ingredient" do
    assert_difference('Ingredients::Ingredient.count') do
      post :create, ingredients_ingredient: { :name => "new ingredient" }
    end

    assert_redirected_to ingredients_ingredient_path(assigns(:ingredients_ingredient))
  end

  test "should show ingredients_ingredient" do
    get :show, id: @ingredients_ingredient
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ingredients_ingredient
    assert_response :success
  end

  test "should update ingredients_ingredient" do
    put :update, id: @ingredients_ingredient, ingredients_ingredient: {  }
    assert_redirected_to ingredients_ingredient_path(assigns(:ingredients_ingredient))
  end

  test "should destroy ingredients_ingredient" do
    assert_difference('Ingredients::Ingredient.count', -1) do
      delete :destroy, id: @ingredients_ingredient
    end

    assert_redirected_to ingredients_ingredients_path
  end
end
