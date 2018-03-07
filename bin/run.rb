require_relative '../config/environment'
# require_relative "../lib/api_communicator.rb"
# require_relative "../lib/command_line_interface.rb"
pid = fork{ exec "afplay", 'media/Funky town Lyrics.mp3'}

hello
user = get_user
get_location(user)
choose_location(user)
switch(user)

pid = fork{ exec ‘killall’, 'afplay' }
