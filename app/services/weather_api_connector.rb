require 'uri'
require 'net/http'
require 'json'

class WeatherApiConnector
  API_KEY = A9n.weather_api_key
  LOCATION = 'Cracow'

  def self.weather_data
    url = "http://api.weatherapi.com/v1/current.json?key=#{API_KEY}&q=#{LOCATION}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    response_json = JSON.parse(response)
    
    if response_json.key?('error') && response_json['error']['code'] == 1006
      puts "Error: No matching location found."

    else
      return response_json
    end
  end
end
