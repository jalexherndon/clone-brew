class Recipe::RecipeTypesController < ApplicationController
  # GET /recipe/recipe_types
  # GET /recipe/recipe_types.json
  def index
    @recipe_recipe_types = Recipe::RecipeType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipe_recipe_types }
    end
  end

  # GET /recipe/recipe_types/1
  # GET /recipe/recipe_types/1.json
  def show
    @recipe_recipe_type = Recipe::RecipeType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe_recipe_type }
    end
  end

  # GET /recipe/recipe_types/new
  # GET /recipe/recipe_types/new.json
  def new
    @recipe_recipe_type = Recipe::RecipeType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe_recipe_type }
    end
  end

  # GET /recipe/recipe_types/1/edit
  def edit
    @recipe_recipe_type = Recipe::RecipeType.find(params[:id])
  end

  # POST /recipe/recipe_types
  # POST /recipe/recipe_types.json
  def create
    @recipe_recipe_type = Recipe::RecipeType.new(params[:recipe_recipe_type])

    respond_to do |format|
      if @recipe_recipe_type.save
        format.html { redirect_to @recipe_recipe_type, notice: 'Recipe type was successfully created.' }
        format.json { render json: @recipe_recipe_type, status: :created, location: @recipe_recipe_type }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe_recipe_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipe/recipe_types/1
  # PUT /recipe/recipe_types/1.json
  def update
    @recipe_recipe_type = Recipe::RecipeType.find(params[:id])

    respond_to do |format|
      if @recipe_recipe_type.update_attributes(params[:recipe_recipe_type])
        format.html { redirect_to @recipe_recipe_type, notice: 'Recipe type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe_recipe_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe/recipe_types/1
  # DELETE /recipe/recipe_types/1.json
  def destroy
    @recipe_recipe_type = Recipe::RecipeType.find(params[:id])
    @recipe_recipe_type.destroy

    respond_to do |format|
      format.html { redirect_to recipe_recipe_types_url }
      format.json { head :no_content }
    end
  end
end
