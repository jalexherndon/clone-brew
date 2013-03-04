require 'spec_helper'

describe IngredientCategoriesController do
  login_user

  before(:each) do
    @ingredient_category = IngredientCategoryBuilder.basic_ingredient_category.build
    @ingredient_category.save!
  end

  it "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredient_categories)
  end

  it "should create ingredient_category" do
    assert_difference('IngredientCategory.count') do
      post :create, ingredient_category: {
        :name => Faker::Lorem.characters(1+rand(60))
      }
    end

    assert_response :created
  end

  it "should show ingredient_category" do
    get :show, id: @ingredient_category
    assert_response :success
  end

  it "should update ingredient_category" do
    put :update, id: @ingredient_category, ingredient_category: {  }
    assert_response :ok
  end

  it "should destroy ingredient_category" do
    assert_difference('IngredientCategory.count', -1) do
      delete :destroy, id: @ingredient_category
    end

    assert_response :no_content
  end
end
