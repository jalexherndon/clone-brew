class Recipe::RecipesController < ApplicationController
  # GET /recipe/recipes
  # GET /recipe/recipes.json
  def index
    @recipe_recipes = Recipe::Recipe.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipe_recipes }
    end
  end

  # GET /recipe/recipes/1
  # GET /recipe/recipes/1.json
  def show
    @recipe_recipe = Recipe::Recipe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe_recipe }
    end
  end

  # GET /recipe/recipes/new
  # GET /recipe/recipes/new.json
  def new
    @recipe_recipe = Recipe::Recipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe_recipe }
    end
  end

  # GET /recipe/recipes/1/edit
  def edit
    @recipe_recipe = Recipe::Recipe.find(params[:id])
  end

  # POST /recipe/recipes
  # POST /recipe/recipes.json
  def create
    @recipe_recipe = Recipe::Recipe.new(params[:recipe_recipe])

    respond_to do |format|
      if @recipe_recipe.save
        format.html { redirect_to @recipe_recipe, notice: 'Recipe was successfully created.' }
        format.json { render json: @recipe_recipe, status: :created, location: @recipe_recipe }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipe/recipes/1
  # PUT /recipe/recipes/1.json
  def update
    @recipe_recipe = Recipe::Recipe.find(params[:id])

    respond_to do |format|
      if @recipe_recipe.update_attributes(params[:recipe_recipe])
        format.html { redirect_to @recipe_recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe/recipes/1
  # DELETE /recipe/recipes/1.json
  def destroy
    @recipe_recipe = Recipe::Recipe.find(params[:id])
    @recipe_recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipe_recipes_url }
      format.json { head :no_content }
    end
  end
end
