class BreweryDbController < ApplicationController
  def search
    @result = BreweryDb.search(params, response, request)
    render json: @result
  end
end
