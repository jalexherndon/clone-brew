class Ingredients::IngredientsController < ApplicationController
  # GET /ingredients/ingredients
  # GET /ingredients/ingredients.json
  def index
    @ingredients_ingredients = Ingredients::Ingredient.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ingredients_ingredients }
    end
  end

  # GET /ingredients/ingredients/1
  # GET /ingredients/ingredients/1.json
  def show
    @ingredients_ingredient = Ingredients::Ingredient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ingredients_ingredient }
    end
  end

  # GET /ingredients/ingredients/new
  # GET /ingredients/ingredients/new.json
  def new
    @ingredients_ingredient = Ingredients::Ingredient.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ingredients_ingredient }
    end
  end

  # GET /ingredients/ingredients/1/edit
  def edit
    @ingredients_ingredient = Ingredients::Ingredient.find(params[:id])
  end

  # POST /ingredients/ingredients
  # POST /ingredients/ingredients.json
  def create
    @ingredients_ingredient = Ingredients::Ingredient.new(params[:ingredients_ingredient])

    respond_to do |format|
      if @ingredients_ingredient.save
        format.html { redirect_to @ingredients_ingredient, notice: 'Ingredient was successfully created.' }
        format.json { render json: @ingredients_ingredient, status: :created, location: @ingredients_ingredient }
      else
        format.html { render action: "new" }
        format.json { render json: @ingredients_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ingredients/ingredients/1
  # PUT /ingredients/ingredients/1.json
  def update
    @ingredients_ingredient = Ingredients::Ingredient.find(params[:id])

    respond_to do |format|
      if @ingredients_ingredient.update_attributes(params[:ingredients_ingredient])
        format.html { redirect_to @ingredients_ingredient, notice: 'Ingredient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ingredients_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/ingredients/1
  # DELETE /ingredients/ingredients/1.json
  def destroy
    @ingredients_ingredient = Ingredients::Ingredient.find(params[:id])
    @ingredients_ingredient.destroy

    respond_to do |format|
      format.html { redirect_to ingredients_ingredients_url }
      format.json { head :no_content }
    end
  end
end
