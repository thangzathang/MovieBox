require_relative 'welcome_view.rb'

first_parameter, *command_parameter = ARGV
ARGV.clear

case first_parameter
when '--help'
  puts 'Hey It\'s the help!'
  puts ''
else
    welcome = Welcome.new
    welcome.show_welcome_menu
end

