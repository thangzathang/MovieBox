require_relative 'views/welcome_view.rb'

first_parameter, *command_parameter = ARGV
ARGV.clear

case first_parameter
when '--help'
  puts ''
  puts 'This is MovieBox!'
  puts 'Created by Thang Za Thang from Coder Academy Melbourne'
  puts 'This ruby CLI application is for users to keep a catalogue of all the movies they watched!'
  puts ''
  puts 'Use the command ./movieBox.sh on the terminal to run the app. Make sure you are in the src folder.'
  puts 'If permission is denued, type the follwing "chmod +x ./movieBox.sh" to gain permission.'
  puts ''
else
    welcome = Welcome.new
    welcome.show_welcome_menu
end
