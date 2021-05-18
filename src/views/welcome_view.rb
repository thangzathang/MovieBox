# External Library
require "Rainbow"
require "tty-prompt"
require "artii"

# Local files
require_relative 'welcome_view.rb'
require_relative 'add_movie_view.rb'
require_relative 'display_movies_view.rb'
require_relative 'delete_update_view.rb'

class Welcome
    def initialize
        @prompt = TTY::Prompt.new
        @arrti = Artii::Base.new :font => 'slant'
    end

    def show_welcome_menu
        loop do 
            system("clear")
            puts "\n"
            puts @arrti.asciify("My Media Box!")

            input = @prompt.select('', cycle: true) do |menu|
                menu.choice 'ADD movie', 1
                menu.choice 'DISPLAY my movies', 2
                menu.choice 'DELETE movie', 3
                menu.choice 'UPDATE movie', 4
                menu.choice 'Imdb Movie Search', 5
                menu.choice 'Exit', 6
            end

            if input == 6
                puts "\n"
                puts "Thanks for playing movie box!".center(50, "+")
                puts "\n"
                break;
            end
            
            digest_input(input)
        end
    end

    def digest_input(input)

        case input 
        when 1
            addMovie = AddMovie.new
            addMovie.run
        when 2
            displayMovie = DisplayMovie.new
            displayMovie.run
        when 3 
            dataManager = DataManager.new
            dataManager.run_delete
        when 4
            dataManager = DataManager.new
            dataManager.run_update
        when 5 
            sleep(1.5)
            puts "Imdb"
        end
    end

end