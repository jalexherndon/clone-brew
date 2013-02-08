class IngredientsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /ingredients
  # GET /ingredients.json
  def index
    @ingredients = Ingredient

    if params.has_key? :name
      @ingredients = @ingredients.where("upper(name) LIKE upper(?)", "#{params[:name]}%")
    end
    if params.has_key? :order
      @ingredients = @ingredients.order(params[:order])
    end
    if params.has_key? :category
      category = IngredientCategory.where("upper(name) = upper(?)", params[:category])
      child_categories = IngredientCategory.where(:parent_ingredient_category_id => category)

      @ingredients = @ingredients.where(:ingredient_category_id => child_categories.concat(category))
    end

    render :json => @ingredients.all
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
    @ingredient = Ingredient.find(params[:id])

    render :json => @ingredient
  end

  # GET /ingredients/new
  # GET /ingredients/new.json
  def new
    @ingredient = Ingredient.new

    render :json => @ingredient
  end

  # GET /ingredients/1/edit
  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  # POST /ingredients
  # POST /ingredients.json
  def create
    @ingredient = Ingredient.new(params[:ingredient])

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully created.' }
        format.json { render json: @ingredient, status: :created, location: @ingredient }
      else
        format.html { render action: "new" }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ingredients/1
  # PUT /ingredients/1.json
  def update
    @ingredient = Ingredient.find(params[:id])

    respond_to do |format|
      if @ingredient.update_attributes(params[:ingredient])
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy

    respond_to do |format|
      format.html { redirect_to ingredients_url }
      format.json { head :no_content }
    end
  end
end
