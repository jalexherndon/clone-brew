class Recipe::TypesController < ApplicationController
  # GET /recipe/types
  # GET /recipe/types.json
  def index
    @recipe_types = Recipe::Type.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipe_types }
    end
  end

  # GET /recipe/types/1
  # GET /recipe/types/1.json
  def show
    @recipe_type = Recipe::Type.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe_type }
    end
  end

  # GET /recipe/types/new
  # GET /recipe/types/new.json
  def new
    @recipe_type = Recipe::Type.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe_type }
    end
  end

  # GET /recipe/types/1/edit
  def edit
    @recipe_type = Recipe::Type.find(params[:id])
  end

  # POST /recipe/types
  # POST /recipe/types.json
  def create
    @recipe_type = Recipe::Type.new(params[:recipe_type])

    respond_to do |format|
      if @recipe_type.save
        format.html { redirect_to @recipe_type, notice: 'Type was successfully created.' }
        format.json { render json: @recipe_type, status: :created, location: @recipe_type }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipe/types/1
  # PUT /recipe/types/1.json
  def update
    @recipe_type = Recipe::Type.find(params[:id])

    respond_to do |format|
      if @recipe_type.update_attributes(params[:recipe_type])
        format.html { redirect_to @recipe_type, notice: 'Type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe/types/1
  # DELETE /recipe/types/1.json
  def destroy
    @recipe_type = Recipe::Type.find(params[:id])
    @recipe_type.destroy

    respond_to do |format|
      format.html { redirect_to recipe_types_url }
      format.json { head :no_content }
    end
  end
end
