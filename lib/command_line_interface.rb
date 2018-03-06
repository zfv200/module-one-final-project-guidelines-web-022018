


def hello
  puts "Welcome to WeatherApp!"
  # get_weather_from_api
end

def get_user
  puts "Please enter User ID"
  user_id = gets.chomp
  User.find_or_create_by(name: user_id)

  # loop do
  #   if user_id.is_a? String
  #     return info.downcase
  #   else
  #     puts "Please enter a valid input!"
  #   end
  # end

  #get input
  #if the user exists, welcome user and ask to get started.
  #return its
  #
end

#user types "what is the temperature?"
def get_temperature

end


























# require "pry"
def welcome
  # puts out a welcome message here!
  puts "Welcome message"
end



def get_movie_from_user
  puts "Please enter a film"
  # use gets to capture the user's input. This method should return that input, downcased.
  user_id = gets.chomp
  loop do
    if info.is_a? String
      return info.downcase
    else
      puts "Please enter a valid input!"
    end
  end
end

def get_character_from_user
  puts "Please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  info = gets.chomp
  loop do
    if info.is_a? String
      return info.downcase
    else
      puts "Please enter a valid input!"
    end
  end
end
