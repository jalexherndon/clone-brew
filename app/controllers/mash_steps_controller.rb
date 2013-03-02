class MashStepsController < ApplicationController
  before_filter :authenticate_user!

  # GET /mash_steps
  def index
    @mash_steps = MashStep.query(params)
    render :json => @mash_steps.all
  end

  # GET /mash_steps/1
  def show
    @mash_step = MashStep.find(params[:id])
    render :json => @mash_step
  end

  # POST /mash_steps
  def create
    @mash_step = MashStep.new(params[:mash_step])

    if @mash_step.save
      render :json => @mash_step, status: :created, location: @mash_step
    else
      render :json => @mash_step.errors, status: :unprocessable_entity
    end
  end

  # PUT /mash_steps/1
  def update
    @mash_step = MashStep.find(params[:id])

    if @mash_step.update_attributes(params[:mash_step])
      render :json => @mash_step
    else
      render :json => @mash_step.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mash_steps/1
  def destroy
    @mash_step = MashStep.find(params[:id])
    @mash_step.destroy

    head :no_content
  end
end
