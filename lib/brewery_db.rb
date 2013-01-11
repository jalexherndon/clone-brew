require 'rubygems'
require 'httparty'

class BreweryDb
  include HTTParty

  base_uri 'http://api.brewerydb.com/v2/'
  format :json
  default_params :format => 'JSON'

  @@apikey = nil
  @@cache = Hash.new()

  PAGE_SIZE = 50

  class << self
    def search( options={}, response={}, request )
      get( :search, options, response, request )
    end

    def get( endpoint="", options={}, response={}, request)
      options.merge! :key => apikey

      endpoint = get_endpoint(endpoint, options)

      request_uri = request.original_fullpath()
      brewery_db_response = nil
      if queryIsCached?(request_uri)
        brewery_db_response = serverFromCache(request_uri)
      else
        brewery_db_response = super( endpoint, :query => options )
        @@cache[request_uri] = brewery_db_response
      end

      add_list_response_headers(brewery_db_response, response)
      get_data_from_response(brewery_db_response)
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


    private
    def queryIsCached?(key)
      @@cache.has_key?(key)
    end

    def serverFromCache(key)
      @@cache[key]
    end

    def add_list_response_headers( data={}, response={} )
      return unless (data.has_key?("currentPage") && data.has_key?("totalResults"))

      startItem = data.fetch("currentPage") * PAGE_SIZE
      endItem = startItem + PAGE_SIZE
      totalResults = data.fetch("totalResults")

      return unless startItem && endItem && totalResults
      response.headers["Content-Range"] = "items #{startItem}-#{endItem}/#{totalResults}"
    end

    def get_endpoint( endpoint, options )
      endpoint = "/#{endpoint}" unless endpoint.is_a? String

      if options.has_key? :id
        endpoint = endpoint + "/#{options[:id]}"
        options.delete :id
      end

      endpoint
    end

    def get_data_from_response(response)
      response.fetch("data") if response.code == 200
    end
  end

end
