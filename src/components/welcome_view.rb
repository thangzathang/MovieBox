require "Rainbow"
require "tty-prompt"
require "artii"

class Welcome
    def initialize
        @prompt = TTY::Prompt.new
        @arrti = Artii::Base.new :font => 'slant'
    end

    def show_welcome_menu
        loop do 
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
            sleep(1.5)
            puts "Add movie"
        when 2
            sleep(1.5)
            puts "Display"
        when 3 
            sleep(1.5)
            puts "Delete"
        when 4
            sleep(1.5)
            puts "Update"
        when 5 
            sleep(1.5)
            puts "Imdb"
        end
    end

end