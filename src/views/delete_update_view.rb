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

    def run_update
        # Simply: 1. Explain how to exit screen. 2. Get the name and check if it already exists. 
        # Validate
        system("clear")
        puts @arrti.asciify("Update a Movie")

        puts "Enter the movie title you want to update:"
        @title = gets.strip

        # Check if they wanna exit
        if @title.chomp.downcase == "exit"
            puts "You have exited!"
            return
        end

        # Check to see if movie exists
        # If it exists confirm with them - use gems.
        # If the above has passed. Let's delete!
        # @crud.update(title, tag, newData)
        movie = @crud.search_movie(@title)
        if movie == "Not Found"
            puts "Movie Not Found"
            sleep(1.5)
            return 
        end

        puts "\nHere is the movie with its tags:"
        movie.each do |key, value|
            puts "#{key.capitalize}: #{value}"
        end
        puts "\n"

        updateTag = @prompt.select("Which tag would you like to update?", cycle: true) do |menu|
            menu.choice 'Movie Title', 1
            menu.choice 'Starring', 2
            menu.choice 'Review', 3
        end

        # We have the title, and the attribute we want to change
        # Now we ask the user for new data to replace the old data.

        case updateTag
        when 1
            puts "What is the new title?"
            newTitle = gets.chomp
           
            @crud.update(@title, "title", newTitle)

            puts "Updates Applied"
            sleep(0.5)
            #Now we should be able to find with the new title
            getUpdatedMovie = @crud.search_movie(newTitle)
            puts "#{getUpdatedMovie[:title]} has been updated"
            sleep(3)
        when 2
            puts "You would like to update starring"
        when 3 
            puts "You would like to updatee review"
        end
        
        input = @prompt.select("Would You Like to update another tag?", cycle: true) do |menu|
            menu.choice 'Update Another', 1
            menu.choice 'Go Back', 2
        end

        if input == 2
            return
        else 
            run_update
        end
    end

    
end