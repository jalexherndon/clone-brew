require 'spec_helper'

describe IngredientDetailsController do
  login_user

  before(:each) do
    @ingredient_detail = IngredientDetailBuilder.basic_ingredient_detail.build
    @ingredient_detail.save!
  end

  it "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredient_details)
  end

  it "should create ingredient_detail" do
    recipe = RecipeBuilder.basic_recipe.build
    recipe.save!

    assert_difference('IngredientDetail.count') do
      post :create, ingredient_detail: {
        :recipe_id => recipe.id,
        :ingredient_id => Ingredient.first.id,
        :amount => 4,
        :units => IngredientDetail::OZ
      }
    end

    assert_response :created
  end

  it "should show ingredient_detail" do
    get :show, id: @ingredient_detail
    assert_response :success
  end

  it "should update ingredient_detail" do
    new_amount = 1 + rand(10)

    response = put :update, id: @ingredient_detail, ingredient_detail: {
      :amount => new_amount
    }

    json_response = JSON.parse(response.body).symbolize_keys

    assert_response :ok
    assert_equal new_amount, json_response[:amount]
  end

  it "should destroy ingredient_detail" do
    assert_difference('IngredientDetail.count', -1) do
      delete :destroy, id: @ingredient_detail
    end

    assert_response :no_content
  end
end
