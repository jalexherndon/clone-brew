require 'rubygems'
require 'httparty'

class BreweryDB
  include HTTParty

  base_uri 'http://api.brewerydb.com/v2/'
  format :json
  default_params :format => 'JSON'

  @@apikey = nil

  def self.search( options={} )
    get( :search, options )
  end

  def self.get( endPoint=:beers, options={} )
    options.merge! :key => apikey

    endPoint = "/#{endPoint}" unless endPoint.is_a? String

    if options.has_key? :id
      endPoint = endPoint + "/#{options[:id]}"
      options.delete :id
    end

    response = super( endPoint, :query => options )
    response.fetch("data") if response.code == 200
  end

  def self.apikey
    @@apikey
  end

  def self.apikey=(apikey)
    @@apikey = apikey
  end

  def self.configure
    yield self
  end
end
