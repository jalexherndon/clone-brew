class BreweryDbController < ApplicationController
  def search
    @result = BreweryDb.search(params, response)
    render json: @result
  end
end
