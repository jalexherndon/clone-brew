class BeersController < ApplicationController
    include QueryHelper

  # GET /beers
  # GET /beers.json
  def index
    @beers = build_list_query Beer, params['sortBy'], params['sortDir']

    respond_to do |format|
      format.json { render json: @beers }
    end
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    @beer = Beer.find(params[:id])

    respond_to do |format|
      format.json { render json: @beer }
    end
  end

  # GET /beers/new
  # GET /beers/new.json
  def new
    @beer = Beer.new

    respond_to do |format|
      format.json { render json: @beer }
    end
  end

  # GET /beers/1/edit
  def edit
    @beer = Beer.find(params[:id])
  end

  # POST /beers
  # POST /beers.json
  def create
    @beer = Beer.new(params[:beer])

    respond_to do |format|
      if @beer.save
        format.json { render json: @beer, status: :created, location: @beer }
      else
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /beers/1
  # PUT /beers/1.json
  def update
    @beer = Beer.find(params[:id])

    respond_to do |format|
      if @beer.update_attributes(params[:beer])
        format.json { head :no_content }
      else
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    @beer = Beer.find(params[:id])
    @beer.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
