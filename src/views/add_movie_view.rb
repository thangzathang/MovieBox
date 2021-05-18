# External Library
require "Rainbow"
require "tty-prompt"
require "artii"

# Local files
require_relative "../engine/validator_engine"
require_relative "../engine/crud_engine"

# This class is simply to get the information
# Pass validations 
# Create obj 
# Save obj to external by contacting crud

class AddMovie
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
        puts @arrti.asciify("Add Movie!")

        movie = {}

        puts "What is the movie called?"
        title = gets.strip

        if title.chomp.downcase == "exit"
            puts "You have exited!"
            return
        end

        movie[:title] = title

        puts "Who does it star?"
        staring = gets.chomp
        movie[:staring] = staring

        puts "What is your review? 1 - 10"
        review = gets.to_i
        movie[:review] = review

        puts "\nThe movie is called #{title}, starring #{staring},and you have scored it #{review} out of 10."

        puts movie

        puts "Movie is saved to database!"

        @crud.save(movie)

        sleep(1.5)

        # 1. Get name
        
        # 2. Check name to see if it already exists

        # 3. If not, move onto asking all the rest.

        # 4. Rest of the questions
    end

    

    
end