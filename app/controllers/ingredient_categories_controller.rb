class IngredientCategoriesController < ApplicationController
  # GET /ingredient_categories
  # GET /ingredient_categories.json
  def index
    @ingredient_categories = IngredientCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ingredient_categories }
    end
  end

  # GET /ingredient_categories/1
  # GET /ingredient_categories/1.json
  def show
    @ingredient_category = IngredientCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ingredient_category }
    end
  end

  # GET /ingredient_categories/new
  # GET /ingredient_categories/new.json
  def new
    @ingredient_category = IngredientCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ingredient_category }
    end
  end

  # GET /ingredient_categories/1/edit
  def edit
    @ingredient_category = IngredientCategory.find(params[:id])
  end

  # POST /ingredient_categories
  # POST /ingredient_categories.json
  def create
    @ingredient_category = IngredientCategory.new(params[:ingredient_category])

    respond_to do |format|
      if @ingredient_category.save
        format.html { redirect_to @ingredient_category, notice: 'Category was successfully created.' }
        format.json { render json: @ingredient_category, status: :created, location: @ingredient_category }
      else
        format.html { render action: "new" }
        format.json { render json: @ingredient_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ingredient_categories/1
  # PUT /ingredient_categories/1.json
  def update
    @ingredient_category = IngredientCategory.find(params[:id])

    respond_to do |format|
      if @ingredient_category.update_attributes(params[:ingredient_category])
        format.html { redirect_to @ingredient_category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ingredient_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredient_categories/1
  # DELETE /ingredient_categories/1.json
  def destroy
    @ingredient_category = IngredientCategory.find(params[:id])
    @ingredient_category.destroy

    respond_to do |format|
      format.html { redirect_to ingredient_categories_url }
      format.json { head :no_content }
    end
  end
end
