


def hello
  puts "Welcome to WeatherApp!"
  # get_weather_from_api
end

def get_user
  puts "Please enter User ID"
  user_id = gets.chomp
  user = User.find_or_create_by(name: user_id)
  user
end

def get_location(user)
  if user.id == User.last.id
    puts "Please enter location (major cities only)"
    #this saves any location entered
    location = gets.chomp
    #make sure it's a valid location
    get_and_save_location(location, user)
    #location_path
  else
    puts "Welcome back, #{user.name}!"
  end
end


def switch(user)
  #switch statement for fun methods
  puts "Enter a number to make a selection: "
  puts "1. What is the temperature for today?"
  puts "2. Is it going to rain today?"
  puts "3. Do I need to wear a jacket today"
  puts "4. Is it going to snow today?"
  puts "5. Is it going to be windy today?"
selection = gets.chomp
  case selection
    when "1"
      get_temperatures(user)
      switch(user)
    when "2"
      rain(user)
      switch(user)
    when "3"
      jacket(user)
      switch(user)
    when "4"
      snow(user)
      switch(user)
    when "5"
      windy(user)
      switch(user)
    else
      puts "Please enter a valid selection"
      switch(user)
    end
end


#user types "what is the temperature?"



























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
