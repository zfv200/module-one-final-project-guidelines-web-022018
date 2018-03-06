# require 'rest-client'
# require 'json'
# require 'pry'

def get_weather_from_api
  #make the web request
  weather_array = []
  all_weather = RestClient.get('https://www.metaweather.com/api/location/2459115/')
  weather_instance = JSON.parse(all_weather)

  current_weather = weather_instance["consolidated_weather"][0]
        # *****  a = (0..(amount of days they want)).to_a *******
  #index [0..8] would return the upcoming week's forecast
  #this is the single weather hash for one day at one location
  weather_array << current_weather
  #we add it to an array so that we have a colle}ction of "weathers"
  #then we want to go through each one, modifying each hash to select the key/value
  #pairs we want to keep
  #we put this in an array called "to be saved"
  to_be_saved = weather_array.collect do |current_weather_by_location|
    current_weather_by_location.select do |k, v|
      %w"weather_state_name min_temp max_temp the_temp wind_speed humidity".include? k
    end

  end

  #go through our array of customized hashes
  #on each one, instantiate a new object using its "attributes"
  #and then save it
  to_be_saved.collect do |weather_hash|
    new_object = Weather.find_or_create_by(condition: weather_hash["weather_state_name"], min_temperature: weather_hash["min_temp"], max_temperature: weather_hash["max_temp"], temperature: weather_hash["the_temp"], wind_speed: weather_hash["wind_speed"], humidity: weather_hash["humidity"])
    # new_object.save
  end



end
