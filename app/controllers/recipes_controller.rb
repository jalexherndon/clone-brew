class RecipesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /recipes
  def index
    @recipes = Recipe.query(params)

    render :json => @recipes.all
  end

  # GET /recipes/1
  def show
    @recipe = Recipe.find(params[:id])
    render :json => @recipe
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    render :json => @recipe
  end

  # POST /recipes
  def create
    recipe_data = ActiveSupport::JSON.decode(params[:recipe]).symbolize_keys
    ingredient_details = recipe_data.delete(:ingredient_details)

    recipe_data[:user] = current_user

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
  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.user != current_user
      render :json => {:success=>false, :message=>"Unauthorized to permorm this action"}, :status=>401
      return
    end

    recipe_data = ActiveSupport::JSON.decode(params[:recipe]).symbolize_keys
    ingredient_details = recipe_data.delete(:ingredient_details)

    @recipe.ingredient_details.clear
    ingredient_details.each do |ingredient_detail|
      ingredient_detail[:recipe_id] = @recipe.id
      @recipe.ingredient_details.build(ingredient_detail)
    end

    if @recipe.update_attributes(recipe_data)
      render :json => @recipe
    else
      render :json => @recipe.errors, :status => :unprocessable_entity
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
