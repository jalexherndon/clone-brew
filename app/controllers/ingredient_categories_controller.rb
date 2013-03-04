class IngredientCategoriesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /ingredient_categories
  # GET /ingredient_categories.json
  def index
    @ingredient_categories = IngredientCategory.query(params)

    render :json => @ingredient_categories.all
  end

  # GET /ingredient_categories/1
  # GET /ingredient_categories/1.json
  def show
    @ingredient_category = IngredientCategory.find(params[:id])

    render :json => @ingredient_category
  end

  # POST /ingredient_categories
  # POST /ingredient_categories.json
  def create
    @ingredient_category = IngredientCategory.new(params[:ingredient_category])

    if @ingredient_category.save
      render :json => @ingredient_category, :status => :created
    else
      render :json => @ingredient_category.errors, :status => :unprocessable_entity
    end
  end

  # PUT /ingredient_categories/1
  # PUT /ingredient_categories/1.json
  def update
    @ingredient_category = IngredientCategory.find(params[:id])

    if @ingredient_category.update_attributes(params[:ingredient_category])
      render :json => @ingredient_category, :status => :ok
    else
      render :json => @ingredient_category.errors, :status => :unprocessable_entity
    end
  end

  # DELETE /ingredient_categories/1
  # DELETE /ingredient_categories/1.json
  def destroy
    @ingredient_category = IngredientCategory.find(params[:id])
    @ingredient_category.destroy

    head :no_content
  end
end
