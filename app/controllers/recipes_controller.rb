class RecipesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
    render :json => @recipes
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
    render :json => @recipe
  end

  # GET /recipes/new
  # GET /recipes/new.json
  def new
    @recipe = Recipe.new
    render :json => @recipe
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes
  # POST /recipes.json
  def create
    recipe_data = ActiveSupport::JSON.decode(params[:recipe]).symbolize_keys
    ingredient_details = recipe_data.delete(:ingredient_details)

    @recipe = Recipe.new(recipe_data)
    
    if @recipe.save
      ingredient_details.each do |ingredient_detail|
        ingredient_detail[:recipe_id] = @recipe.id
        @recipe.ingredient_details.build(ingredient_detail)
      end
    end

    if @recipe.save
      render :json => @recipe, :status => :created
    else
      recipe_errors = @recipe.errors
      @recipe.delete
      render :json => recipe_errors, :status => :unprocessable_entity
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.json
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end
end
