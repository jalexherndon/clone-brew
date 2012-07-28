class Ingredients::CategoriesController < ApplicationController
  # GET /ingredients/categories
  # GET /ingredients/categories.json
  def index
    @ingredients_categories = Ingredients::Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ingredients_categories }
    end
  end

  # GET /ingredients/categories/1
  # GET /ingredients/categories/1.json
  def show
    @ingredients_category = Ingredients::Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ingredients_category }
    end
  end

  # GET /ingredients/categories/new
  # GET /ingredients/categories/new.json
  def new
    @ingredients_category = Ingredients::Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ingredients_category }
    end
  end

  # GET /ingredients/categories/1/edit
  def edit
    @ingredients_category = Ingredients::Category.find(params[:id])
  end

  # POST /ingredients/categories
  # POST /ingredients/categories.json
  def create
    @ingredients_category = Ingredients::Category.new(params[:ingredients_category])

    respond_to do |format|
      if @ingredients_category.save
        format.html { redirect_to @ingredients_category, notice: 'Category was successfully created.' }
        format.json { render json: @ingredients_category, status: :created, location: @ingredients_category }
      else
        format.html { render action: "new" }
        format.json { render json: @ingredients_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ingredients/categories/1
  # PUT /ingredients/categories/1.json
  def update
    @ingredients_category = Ingredients::Category.find(params[:id])

    respond_to do |format|
      if @ingredients_category.update_attributes(params[:ingredients_category])
        format.html { redirect_to @ingredients_category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ingredients_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/categories/1
  # DELETE /ingredients/categories/1.json
  def destroy
    @ingredients_category = Ingredients::Category.find(params[:id])
    @ingredients_category.destroy

    respond_to do |format|
      format.html { redirect_to ingredients_categories_url }
      format.json { head :no_content }
    end
  end
end
