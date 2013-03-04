class IngredientDetailsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /ingredient_details
  # GET /ingredient_details.json
  def index
    @ingredient_details = IngredientDetail.query(params)

    render :json => @ingredient_details.all
  end

  # GET /ingredient_details/1
  # GET /ingredient_details/1.json
  def show
    @ingredient_detail = IngredientDetail.find(params[:id])

    render :json => @ingredient_detail
  end

  # POST /ingredient_details
  # POST /ingredient_details.json
  def create
    @ingredient_detail = IngredientDetail.new(params[:ingredient_detail])

    if @ingredient_detail.save
      render :json => @ingredient_detail, status: :created, location: @ingredient_detail
    else
      render :json => @ingredient_detail.errors, status: :unprocessable_entity
    end
  end

  # PUT /ingredient_details/1
  # PUT /ingredient_details/1.json
  def update
    @ingredient_detail = IngredientDetail.find(params[:id])

    if @ingredient_detail.update_attributes(params[:ingredient_detail])
      render :json => @ingredient_detail, :status => :ok
    else
      render :json => @ingredient_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ingredient_details/1
  # DELETE /ingredient_details/1.json
  def destroy
    @ingredient_detail = IngredientDetail.find(params[:id])
    @ingredient_detail.destroy

    head :no_content
  end
end
