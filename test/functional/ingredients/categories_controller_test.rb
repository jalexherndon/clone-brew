require 'test_helper'

class Ingredients::CategoriesControllerTest < ActionController::TestCase
  setup do
    @ingredients_category = ingredients_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredients_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ingredients_category" do
    assert_difference('Ingredients::Category.count') do
      post :create, ingredients_category: { description: @ingredients_category.description, name: @ingredients_category.name }
    end

    assert_redirected_to ingredients_category_path(assigns(:ingredients_category))
  end

  test "should show ingredients_category" do
    get :show, id: @ingredients_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ingredients_category
    assert_response :success
  end

  test "should update ingredients_category" do
    put :update, id: @ingredients_category, ingredients_category: { description: @ingredients_category.description, name: @ingredients_category.name }
    assert_redirected_to ingredients_category_path(assigns(:ingredients_category))
  end

  test "should destroy ingredients_category" do
    assert_difference('Ingredients::Category.count', -1) do
      delete :destroy, id: @ingredients_category
    end

    assert_redirected_to ingredients_categories_path
  end
end
