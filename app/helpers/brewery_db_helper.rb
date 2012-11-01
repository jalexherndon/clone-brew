module BreweryDbHelper
  BASE_URL = "http://api.brewerydb.com/v2/"
  KEY_NAME = 'key'
  KEY_VALUE = "0fb6c5cb661debb778abab36077502a9"

  def queryBreweryDBFor(endPoint, query_string)
    url = URI.parse( BASE_URL + endPoint + "/?" + KEY_NAME + "=" + KEY_VALUE + '&' + request.query_string)
    json_response = Net::HTTP.get(url)
    response = ActiveSupport::JSON.decode(json_response)

    if response.fetch('status') == 'failure'
      []
    else
      ActiveSupport::JSON.encode(response.fetch('data'))
    end
  end

end
