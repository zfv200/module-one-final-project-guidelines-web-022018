# require 'rest-client'
# require 'json'
# require 'pry'

#these should be parsed out into different functions

def get_and_save_location(location, user)
  query_link = "https://www.metaweather.com/api/location/search/?query=#{location}"

  city_data = RestClient.get(query_link)
  city_array = JSON.parse(city_data)
  woeid = city_array[0]["woeid"]
  #maybe give locations a name?
  new_location = Location.find_or_create_by(name: city_array[0]["title"])
  user.locations << new_location
  woeid
  # new_location.user_id = user.id
  #how to add the weatherID??????
  #we're trying to add the location as an object, based on some convenient attribute
  # city_array[0]["title"] #= string of city name
end


def get_weather_data(get_and_save_location)
  weather_array = []
  woeid = get_and_save_location

  all_weather = RestClient.get("https://www.metaweather.com/api/location/#{woeid}/")
  weather_forecast = JSON.parse(all_weather)

  current_weather = weather_forecast["consolidated_weather"][0]

  weather_array << current_weather

  to_be_saved = weather_array.collect do |current_weather_by_location|
    current_weather_by_location.select do |k, v|
      %w"weather_state_name min_temp max_temp the_temp wind_speed humidity".include? k
    end
  end

  to_be_saved.collect do |weather_hash|
    new_object = Weather.find_or_create_by(condition: weather_hash["weather_state_name"], min_temperature: weather_hash["min_temp"], max_temperature: weather_hash["max_temp"], temperature: weather_hash["the_temp"], wind_speed: weather_hash["wind_speed"], humidity: weather_hash["humidity"])
    # new_object.save
  end

end

def get_temperatures(user)
  weather = get_weather_data(get_and_save_location(user.locations[0].name, user))
  current_temp = (weather[0].temperature.to_f * 1.8 + 32).ceil
  min = (weather[0].min_temperature.to_f * 1.8 + 32).ceil
  max = (weather[0].max_temperature.to_f * 1.8 + 32).ceil
  puts "Your forecast for today: Current temperature is #{current_temp} degrees Fahrenheit
  with a low of #{min} and a high of #{max}."
end


#
#
# def get_weather_from_api(location)
#   #make the web request
#
#   query_link = "https://www.metaweather.com/api/location/search/?query=#{location}"
#
#   #we need to save the location as an object using the location data
#   binding.pry
#
#   # all_weather = RestClient.get('https://www.metaweather.com/api/location/2459115/')
#   city_data = RestClient.get(query_link)
#   city_array = JSON.parse(city_data)
#   woeid = city_array[0]["woeid"]
#   #city_array[]
#
# ##############################################
#   weather_array = []
#   all_weather = RestClient.get("https://www.metaweather.com/api/location/#{woeid}/")
#   weather_forecast = JSON.parse(all_weather)
#
#
#   current_weather = weather_forecast["consolidated_weather"][0]
#         # *****  a = (0..(amount of days they want)).to_a *******
#   #index [0..8] would return the upcoming week's forecast
#   #this is the single weather hash for one day at one location
#   weather_array << current_weather
#   #we add it to an array so that we have a colle}ction of "weathers"
#   #then we want to go through each one, modifying each hash to select the key/value
#   #pairs we want to keep
#   #we put this in an array called "to be saved"
#   to_be_saved = weather_array.collect do |current_weather_by_location|
#     current_weather_by_location.select do |k, v|
#       %w"weather_state_name min_temp max_temp the_temp wind_speed humidity".include? k
#     end
#
#   end
#
#   #go through our array of customized hashes
#   #on each one, instantiate a new object using its "attributes"
#   #and then save it
#   to_be_saved.collect do |weather_hash|
#     new_object = Weather.find_or_create_by(condition: weather_hash["weather_state_name"], min_temperature: weather_hash["min_temp"], max_temperature: weather_hash["max_temp"], temperature: weather_hash["the_temp"], wind_speed: weather_hash["wind_speed"], humidity: weather_hash["humidity"])
#     # new_object.save
#   end
#
#
# end
