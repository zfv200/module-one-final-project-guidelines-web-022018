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

  #answer is in here, need to create a location with a weather
  new_location = Location.find_or_create_by(name: city_array[0]["title"])
  new_location.user_id = user.id
  # user.locations << new_location
  #refactor as a hash passed in to an update function
  new_location.weather_id = get_weather_data(woeid)[0].id
  new_location.save

  # user.save
  woeid
  # new_location.user_id = user.id
  #how to add the weatherID??????
  #we're trying to add the location as an object, based on some convenient attribute
  # city_array[0]["title"] #= string of city name
end

def update_weather(location, user, old_weather)
  query_link = "https://www.metaweather.com/api/location/search/?query=#{location}"

  city_data = RestClient.get(query_link)
  city_array = JSON.parse(city_data)
  woeid = city_array[0]["woeid"]


  all_weather = RestClient.get("https://www.metaweather.com/api/location/#{woeid}/")
  weather_forecast = JSON.parse(all_weather)

  current_weather = weather_forecast["consolidated_weather"][0]
  old_weather.update(condition: current_weather["weather_state_name"], min_temperature: current_weather["min_temp"], max_temperature: current_weather["max_temp"], temperature: current_weather["the_temp"], wind_speed: current_weather["wind_speed"], humidity: current_weather["humidity"])
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
  weather = get_weather_data(get_and_save_location(user.locations[user.current_location].name, user))
  current_temp = (weather[0].temperature.to_f * 1.8 + 32).ceil
  min = (weather[0].min_temperature.to_f * 1.8 + 32).ceil
  max = (weather[0].max_temperature.to_f * 1.8 + 32).ceil
  puts "**************************************************************************".colorize(:light_yellow)
  puts "Your forecast for today: Current temperature is #{current_temp} degrees Fahrenheit
  with a low of #{min} and a high of #{max}."
end

def snow(user)
  # binding.pry
  weather = get_weather_data(get_and_save_location(user.locations[user.current_location].name, user))
  condition = weather[0]["condition"].downcase
  if condition.include?("snow") || condition.include?("hail") || condition.include?("sleet")
    puts "**************************************************************************".colorize(:light_yellow)
    puts "It gonna snow".colorize(:red)
  else
    puts "**************************************************************************".colorize(:light_yellow)
    puts "It ain't gonna snow".colorize(:red)
  end
end

def rain(user)
  # binding.pry
  weather = get_weather_data(get_and_save_location(user.locations[user.current_location].name, user))
  condition = weather[0]["condition"].downcase
  if condition.include?("heavy rain") || condition.include?("light rain") || condition.include?("thunderstorm") || condition.include?("showers")
    puts "**************************************************************************".colorize(:light_yellow)
    puts "It gonna rain".colorize(:red)
  else
    puts "**************************************************************************".colorize(:light_yellow)
    puts "Uh uh, it ain't gonna rain".colorize(:red)
  end
end

def windy(user)
  # binding.pry
  weather = get_weather_data(get_and_save_location(user.locations[user.current_location].name, user))
  wind_speed = weather[0]["wind_speed"].to_f.ceil
  if wind_speed > 15
    puts "**************************************************************************".colorize(:light_yellow)
    puts "O it windy".colorize(:red)
  else
    puts "**************************************************************************".colorize(:light_yellow)
    puts "Na it ain't that windy".colorize(:red)
  end
end

def jacket(user)
  weather = get_weather_data(get_and_save_location(user.locations[user.current_location].name, user))
  current_temp = (weather[0].temperature.to_f * 1.8 + 32).ceil
  if current_temp < 50
    puts "**************************************************************************".colorize(:light_yellow)
    puts "You best be putting on yo jacket".colorize(:red)
  else
    puts "**************************************************************************".colorize(:light_yellow)
    puts "Na you won't be needin yo jacket".colorize(:red)
  end
end

def list_all_conditions(user)
   user.weathers.each do |i|
     puts "**************************************************************************".colorize(:light_yellow)
     puts "#{i.locations[0].name}: #{i["condition"]} with a high of #{(i["max_temperature"].to_f * 1.8 + 32).ceil} degrees Fahrenheit".colorize(:red)
   end
end

def update_all_weathers(user)
  user.weathers.each do |weather|
    location = weather.locations[0].name
     update_weather(location, user, weather)
   end
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
