


def hello
  # a = Artii::Base.new :font => "slant"
  # a.asciify(Welcome to WeatherApp!’)
  # puts "Welcome to WeatherApp!"
  # get_weather_from_api
  a = Artii::Base.new

   # puts a.asciify("W").colorize(:red)
   # sleep(1.0/2.0)
   # puts a.asciify("E").colorize(:light_yellow)
   # sleep(1.0/2.0)
   # puts a.asciify("A")
   # sleep(1.0/2.0)
   # puts a.asciify("T").colorize(:cyan)
   # sleep(1.0/2.0)
   # puts a.asciify("H").colorize(:red)
   # sleep(1.0/2.0)
   # puts a.asciify("E").colorize(:light_yellow)
   # sleep(1.0/2.0)
   # puts a.asciify("R")
   # sleep(1)
   # puts a.asciify("WeatherApp").colorize(:cyan)
   # sleep(2)
   puts "For all your weather needs.".colorize(:light_red)
end

def get_user
  # sleep(2)
  puts "Please enter User ID".colorize(:light_yellow)
  # sleep(2)
  # puts "(Yes, this is funkytown)"
  user_id = gets.chomp
  user = User.find_or_create_by(name: user_id)
  user
end

def get_location(user)
  # if user.id == User.last.id
  if user.locations.empty?
    puts "**************************************************************************".colorize(:light_yellow)
    puts "Please enter your first location (major cities only)"
    #this saves any location entered
    location = gets.chomp
    #make sure it's a valid location
    if valid?(location)
      get_and_save_location(location, user)
      #location_path
      user.current_location = 0
      user.save
    else
      puts "**************************************************************************".colorize(:light_yellow)
      puts "City not recognized. Please enter a valid location"
      puts "**************************************************************************".colorize(:light_yellow)
      get_location(user)
    end
  else
    puts "**************************************************************************".colorize(:light_yellow)
    puts "Welcome back, #{user.name}!".colorize(:cyan)
    #go through each of the users weathers and update them to be accurate
    #maybe write a method that would be called on each of them to do this
    #we have all the code necessary to do this
  end
end

def game_or_weather(user)
  puts "Enter a number to make a selection"
  puts "1. Get the weather"
  puts "2. Play a weather game"
  decision = gets.chomp
    case decision
      when "1"
        choose_location(user)
      when "2"
        puts "work in progress"
        #game_method

      else
        puts "Please enter a valid selection"
        game_or_weather(user)
    end
end

def choose_location(user)
  puts "Enter a number to make a selection".colorize(:cyan)
  puts "1. Choose saved location".colorize(:light_red)
  puts "2. Choose new location".colorize(:light_yellow)
  selection = gets.chomp
    case selection
      when "1"
        # which location?
        switch_location(user)
      when "2"
        puts "Enter your new location"
        location = gets.chomp
        #make sure it's a valid location
        # binding.pry
        if valid?(location)
          get_and_save_location(location, user)
          user.current_location = (user.locations.count - 1)
          switch(user)
          user.save
        else
          puts "**************************************************************************".colorize(:light_yellow)
          puts "Please enter a valid selection"
          puts "**************************************************************************".colorize(:light_yellow)
          choose_location(user)
        end
      when "exit"
        abort("Goodbye!")
      else
        puts "**************************************************************************".colorize(:light_yellow)
        puts "Please enter a valid selection"
        puts "**************************************************************************".colorize(:light_yellow)
        choose_location(user)
    end
end

def switch_location(user)
  puts "**************************************************************************".colorize(:light_yellow)
  count = 1
  color_number = 1
  color_hash = {1 => :green, 2 => :cyan, 3 => :red, 4 => :light_yellow}
  user.locations.each do |location|
    puts "#{count}: #{location.name}".colorize(color_hash[color_number])
    count += 1
    color_number += 1
    if color_number == 5
      color_number = 1
    end
  end
  puts "Please make your selection".colorize(:cyan)
  location_count = user.locations.count
  location_selection = gets.chomp
    if location_selection.to_i > 0 && location_selection.to_i < location_count + 1
      user.current_location = location_selection.to_i - 1
      #grab the location's name
      to_be_updated = user.locations[location_selection.to_i - 1].name
      old_weather = user.locations[location_selection.to_i - 1].weather
      update_weather(to_be_updated, user, old_weather)
      user.save
      # binding.pry
    else
      puts "Please enter a valid selection"
      switch_location(user)
    end
end
##this don't work good




def switch(user)
  # binding.pry
  #switch statement for fun methods
  puts "**************************************************************************".colorize(:light_yellow)
  puts "Enter a number to make a selection: "
  puts "1. What is the temperature for today?".colorize(:cyan)
  puts "2. Is it going to rain today?".colorize(:red)
  puts "3. Do I need to wear a jacket today?".colorize(:light_yellow)
  puts "4. Is it going to snow today?"
  puts "5. Is it going to be windy today?".colorize(:cyan)
  puts "6. List all my locations' weather.".colorize(:red)
  puts "7. Change location".colorize(:light_yellow)
  puts "8. Exit WeatherApp"
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
    when "6"
      update_all_weathers(user)
      list_all_conditions(user)
      switch(user)
    when "7"
      choose_location(user)
    when "8"
      #exit statement
      abort("Goodbye!")
    else
      puts "Please enter a valid selection"
      switch(user)
    end
end
