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

  # POST /recipes
  def create
    recipe_data = params[:recipe]
    if recipe_data.is_a? String
      recipe_data = ActiveSupport::JSON.decode(recipe_data).symbolize_keys
    end

    recipe_data[:user] = current_user

    ingredient_details = recipe_data.delete(:ingredient_details)
    
    @recipe = Recipe.new(recipe_data)
    if @recipe.save
      unless ingredient_details.nil?
        ingredient_details.each do |ingredient_detail|
          ingredient_detail[:recipe_id] = @recipe.id
          @recipe.ingredient_details.build(ingredient_detail)
        end
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
      render :json => {:success=>false, :message=>"Unauthorized to permorm this action"}, :status => 401
      return
    end

    recipe_data = params[:recipe]
    if recipe_data.is_a? String
      recipe_data = ActiveSupport::JSON.decode(recipe_data).symbolize_keys
    end

    sanitize_data! recipe_data

    ingredient_details = recipe_data.delete(:ingredient_details)
    unless ingredient_details.nil?
      @recipe.ingredient_details.clear
      ingredient_details.each do |ingredient_detail|
        ingredient_detail[:recipe_id] = @recipe.id
        @recipe.ingredient_details.build(ingredient_detail)
      end
    end

    if @recipe.update_attributes(recipe_data)
      render :json => @recipe, :status => :ok
    else
      puts "\n\nErrors saving recipe:\n#{@recipe.errors}"
      render :json => @recipe.errors, :status => :unprocessable_entity
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    head :no_content
  end

  private
  def sanitize_data!(data = {})
    data.delete :id
    data.delete :created_at
    data.delete :updated_at
    data.delete :user
    data.delete :user_id
  end
end
