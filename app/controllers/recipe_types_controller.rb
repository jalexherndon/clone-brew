class RecipeTypesController < ApplicationController
  # GET /recipe_types
  # GET /recipe_types.json
  def index
    @recipe_types = RecipeType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipe_types }
    end
  end

  # GET /recipe_types/1
  # GET /recipe_types/1.json
  def show
    @recipe_type = RecipeType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe_type }
    end
  end

  # GET /recipe_types/new
  # GET /recipe_types/new.json
  def new
    @recipe_type = RecipeType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe_type }
    end
  end

  # GET /recipe_types/1/edit
  def edit
    @recipe_type = RecipeType.find(params[:id])
  end

  # POST /recipe_types
  # POST /recipe_types.json
  def create
    @recipe_type = RecipeType.new(params[:recipe_type])

    respond_to do |format|
      if @recipe_type.save
        format.html { redirect_to @recipe_type, notice: 'Recipe type was successfully created.' }
        format.json { render json: @recipe_type, status: :created, location: @recipe_type }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipe_types/1
  # PUT /recipe_types/1.json
  def update
    @recipe_type = RecipeType.find(params[:id])

    respond_to do |format|
      if @recipe_type.update_attributes(params[:recipe_type])
        format.html { redirect_to @recipe_type, notice: 'Recipe type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_types/1
  # DELETE /recipe_types/1.json
  def destroy
    @recipe_type = RecipeType.find(params[:id])
    @recipe_type.destroy

    respond_to do |format|
      format.html { redirect_to recipe_types_url }
      format.json { head :no_content }
    end
  end
end
