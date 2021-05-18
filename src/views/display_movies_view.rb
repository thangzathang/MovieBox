# External Library
require "Rainbow"
require "tty-prompt"
require "artii"

# Local files
require_relative "../engine/validator_engine"
require_relative "../engine/crud_engine"

# This class is simply to display the movies
# Use the tty-table or the terminal table
# Make it pretty

class DisplayMovie
    def initialize
        @valdiator = Validator.new
        @prompt = TTY::Prompt.new
        @arrti = Artii::Base.new :font => 'slant'
        @crud = Crud.new
    end

    def run
        # Simply: 1. Explain how to exit screen. 2. Get the name and check if it already exists. 
        # Validator works
        system("clear")
        puts @arrti.asciify("Display Movie!")

        # For now just display all movies, maybe with an index.
        puts "\n\n"
        puts @crud.get_movies
        puts "\n\n"

        input = @prompt.select('Show by filter', cycle: true) do |menu|
            menu.choice 'Filter by recent add', 1
            menu.choice 'Filter by review', 2
            menu.choice 'Filter by alphabetical order', 3
            menu.choice 'Go Back', 4
        end

        if input == 4
            return
        end

        case input 
        when 1
            puts "Filter by recent"
        when 2
            puts "Filter by review"
        when 3
            puts "Filter by alphabetical order"
        end
    end

    

    
end