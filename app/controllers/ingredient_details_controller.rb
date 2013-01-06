class IngredientDetailsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /ingredient_details
  # GET /ingredient_details.json
  def index
    @ingredient_details = IngredientDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ingredient_details }
    end
  end

  # GET /ingredient_details/1
  # GET /ingredient_details/1.json
  def show
    @ingredient_detail = IngredientDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ingredient_detail }
    end
  end

  # GET /ingredient_details/new
  # GET /ingredient_details/new.json
  def new
    @ingredient_detail = IngredientDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ingredient_detail }
    end
  end

  # GET /ingredient_details/1/edit
  def edit
    @ingredient_detail = IngredientDetail.find(params[:id])
  end

  # POST /ingredient_details
  # POST /ingredient_details.json
  def create
    @ingredient_detail = IngredientDetail.new(params[:ingredient_detail])

    respond_to do |format|
      if @ingredient_detail.save
        format.html { redirect_to @ingredient_detail, notice: 'Ingredient detail was successfully created.' }
        format.json { render json: @ingredient_detail, status: :created, location: @ingredient_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @ingredient_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ingredient_details/1
  # PUT /ingredient_details/1.json
  def update
    @ingredient_detail = IngredientDetail.find(params[:id])

    respond_to do |format|
      if @ingredient_detail.update_attributes(params[:ingredient_detail])
        format.html { redirect_to @ingredient_detail, notice: 'Ingredient detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ingredient_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredient_details/1
  # DELETE /ingredient_details/1.json
  def destroy
    @ingredient_detail = IngredientDetail.find(params[:id])
    @ingredient_detail.destroy

    respond_to do |format|
      format.html { redirect_to ingredient_details_url }
      format.json { head :no_content }
    end
  end
end
