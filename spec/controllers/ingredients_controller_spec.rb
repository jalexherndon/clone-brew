require 'spec_helper'

describe IngredientsController do
  login_user

  before(:each) do
    @ingredient = IngredientBuilder.basic_ingredient.build
    @ingredient.save!
  end

  it "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredients)
  end

  it "should create ingredient" do
    assert_difference('Ingredient.count') do
      post :create, ingredient: {
        :name => "name",
        :ingredient_category_id => IngredientCategory.limit(1).first.id
      }
    end

    assert_response :success
  end

  it "should show ingredient" do
    get :show, id: @ingredient
    assert_response :success
  end

  it "should update ingredient" do
    new_name = "alkasdslnf"

    response = put :update, id: @ingredient, ingredient: {
      :name => new_name,
      :ingredient_category_id => @ingredient.ingredient_category_id
    }

    json_response = JSON.parse(response.body).symbolize_keys

    assert_response :success
    assert_equal new_name, json_response[:name]
  end

  it "should destroy ingredient" do
    assert_difference('Ingredient.count', -1) do
      delete :destroy, id: @ingredient
    end

    assert_redirected_to ingredients_path
  end
end
