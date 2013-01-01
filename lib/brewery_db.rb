require 'rubygems'
require 'httparty'

class BreweryDb
  include HTTParty

  base_uri 'http://api.brewerydb.com/v2/'
  format :json
  default_params :format => 'JSON'

  @@apikey = nil

  PAGE_SIZE = 50

  class << self
    def search( options={}, response={} )
      get( :search, options, response )
    end

    def get( endpoint="", options={}, response={} )
      options.merge! :key => apikey

      isGet = options.has_key? :id
      endpoint = get_endpoint(endpoint, options)
      resp = super( endpoint, :query => options )

      handle_error(resp)
      add_list_response_headers(resp, response) unless isGet
      get_data_from_response(resp)
    end

    def apikey
      @@apikey
    end

    def apikey=(apikey)
      @@apikey = apikey
    end

    def configure
      yield self
    end
  end

  private
  def self.add_list_response_headers( data={}, response={} )
    startItem = data.fetch("currentPage") * PAGE_SIZE
    endItem = startItem + PAGE_SIZE
    totalResults = data.fetch("totalResults")

    return unless startItem && endItem && totalResults
    response.headers["Content-Range"] = "items #{startItem}-#{endItem}/#{totalResults}"
  end

  def self.get_endpoint( endpoint, options )
    endpoint = "/#{endpoint}" unless endpoint.is_a? String

    if options.has_key? :id
      endpoint = endpoint + "/#{options[:id]}"
      options.delete :id
    end

    endpoint
  end

  def self.handle_error(response)
  end

  def self.get_data_from_response(response)
    response.fetch("data") if response.code == 200
  end
end
