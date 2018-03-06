require_relative '../config/environment'
# require_relative "../lib/api_communicator.rb"
# require_relative "../lib/command_line_interface.rb"

hello
user = get_user
get_location(user)
get_temperatures(user)
