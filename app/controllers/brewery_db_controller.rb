class BreweryDbController < ApplicationController
  before_filter :authenticate_user!
  
  def search
    @result = BreweryDb.search(params, response, request)
    render json: @result
  end
end
