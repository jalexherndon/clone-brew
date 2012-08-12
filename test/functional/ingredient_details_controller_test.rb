require 'test_helper'

class IngredientDetailsControllerTest < ActionController::TestCase
  setup do
    @ingredient_detail = ingredient_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredient_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ingredient_detail" do
    assert_difference('IngredientDetail.count') do
      post :create, ingredient_detail: {  }
    end

    assert_redirected_to ingredient_detail_path(assigns(:ingredient_detail))
  end

  test "should show ingredient_detail" do
    get :show, id: @ingredient_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ingredient_detail
    assert_response :success
  end

  test "should update ingredient_detail" do
    put :update, id: @ingredient_detail, ingredient_detail: {  }
    assert_redirected_to ingredient_detail_path(assigns(:ingredient_detail))
  end

  test "should destroy ingredient_detail" do
    assert_difference('IngredientDetail.count', -1) do
      delete :destroy, id: @ingredient_detail
    end

    assert_redirected_to ingredient_details_path
  end
end
