class BetaUsersController < ApplicationController
  # GET /beta_users
  # GET /beta_users.json
  def index
    @beta_users = BetaUser.all
    render json: @beta_users
  end

  # GET /beta_users/1
  # GET /beta_users/1.json
  def show
    @beta_user = BetaUser.find(params[:id])
    render json: @beta_user
  end

  # POST /beta_users
  # POST /beta_users.json
  def create
    @beta_user = BetaUser.new(params[:beta_user])

    if @beta_user.save
      render json: @beta_user, status: :created, location: @beta_user
    else
      render json: @beta_user.errors, status: :unprocessable_entity
    end
  end

  # PUT /beta_users/1
  # PUT /beta_users/1.json
  def update
    @beta_user = BetaUser.find(params[:id])

    if @beta_user.update_attributes(params[:beta_user])
      head :no_content
    else
      render json: @beta_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /beta_users/1
  # DELETE /beta_users/1.json
  def destroy
    @beta_user = BetaUser.find(params[:id])
    @beta_user.destroy

    head :no_content
  end
end
