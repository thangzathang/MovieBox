# External Library
require "Rainbow"
require "tty-prompt"
require "artii"

# Local files
require_relative "../engine/validator_engine"
require_relative "../engine/crud_engine"

# This class is for Deleting and Updatting
# Pass validations 
# Create obj 
# Save obj to external by contacting crud

class DataManager
    def initialize
        @valdiator = Validator.new
        @prompt = TTY::Prompt.new
        @arrti = Artii::Base.new :font => 'slant'
        @crud = Crud.new
    end

    def run_delete
        # Simply: 1. Explain how to exit screen. 2. Get the name and check if it already exists. 
        # Validate
        system("clear")
        puts @arrti.asciify("Delete a Movie")

        puts "Enter the movie title you want to delete:"
        title = gets.strip

        # Check if they wanna exit
        if title.chomp.downcase == "exit"
            puts "You have exited!"
            return
        end

        # Check to see if movie exists

        # If it exists confirm with them - use gems.

        # If the above has passed. Let's delete!

        @crud.delete(title)

        input = @prompt.select("Would You Like to Delete Another?", cycle: true) do |menu|
            menu.choice 'Delete Another', 1
            menu.choice 'Go Back', 2
        end

        if input == 2
            return
        else 
            run_delete
        end

    end

    
end