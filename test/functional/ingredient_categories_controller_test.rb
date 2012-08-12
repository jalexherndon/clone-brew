require 'test_helper'

class IngredientCategoriesControllerTest < ActionController::TestCase
  setup do
    @ingredient_category = ingredient_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredient_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ingredient_category" do
    assert_difference('IngredientCategory.count') do
      post :create, ingredient_category: {  }
    end

    assert_redirected_to ingredient_category_path(assigns(:ingredient_category))
  end

  test "should show ingredient_category" do
    get :show, id: @ingredient_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ingredient_category
    assert_response :success
  end

  test "should update ingredient_category" do
    put :update, id: @ingredient_category, ingredient_category: {  }
    assert_redirected_to ingredient_category_path(assigns(:ingredient_category))
  end

  test "should destroy ingredient_category" do
    assert_difference('IngredientCategory.count', -1) do
      delete :destroy, id: @ingredient_category
    end

    assert_redirected_to ingredient_categories_path
  end
end
