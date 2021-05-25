# External Library
require "Rainbow"
require "tty-prompt"
require "artii"
require "tty-box"

# Local files
require_relative "../engine/validator_engine"
require_relative "../engine/crud_engine"
require_relative "../utilities/message_box"
require_relative "./display_movies_view"

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
        @msgBox = MessageBox.new
        @display = DisplayMovie.new
    end

    def run_delete
        system("clear")
        puts @arrti.asciify("Delete a Movie") 

        movieTitle = @msgBox.allCaps(@msgBox.getString("Enter the title of the movie you want to delete:"))
        return if movieTitle == "exit" 
        movieArr = @crud.search_movie_by_args(movieTitle, "title")

        if movieArr.size == 0 
            @msgBox.printWarning("Movie does not exist!", 1.8)
            return
        end

        movieArr.each do |movie|
            @display.displayMovieInfo(movie)
        end

        # Get the year to not mistake for duplicates
        movieYear = @msgBox.getInteger("Enter the release year:")
        return if movieYear == "exit"

    #DEMO
        # Get the movie with the title and year specified.
        theMovie = @crud.search_movie_with_year(movieTitle, movieYear)
 
        @msgBox.printSuccess("Movie successfully retrieved! Here is the data:", 1.2)
        @display.displayMovie(theMovie)

        # The acttula deleting is done here.
        # Ask to confirm if they want to delete

         confirm = @msgBox.get("Are you sure you want to delete #{theMovie[:title]}( yes/ no )")

        if confirm.chomp.downcase == "yes" 
            print TTY::Box.success("Successfully deleted #{theMovie[:title]}").center(20)

            @crud.delete(movieTitle, movieYear)
            
        else 
            print TTY::Box.error("Did not delete #{theMovie[:title]}").center(20)
        end

        puts "Press Enter to continue"
        enter = gets
        return
    end

    def run_update
        system("clear")
        puts @arrti.asciify("Update a Movie")

        # Show the movies with this name!
# The begin and end is same as the run_delete
# =begin
        @movieTitle = @msgBox.allCaps(@msgBox.getString("Enter the title of the movie you want to update:"))
        return if @movieTitle == "exit" 
        movieArr = @crud.search_movie_by_args(@movieTitle, "title")

        if movieArr.size == 0
            @msgBox.printWarning("Movie does not exist!", 1.8)
            return
        end

        movieArr.each do |movie|
            @display.displayMovieInfo(movie)
        end

        # Get the year to not mistake for duplicates
        @movieYear = @msgBox.getInteger("Enter the release year:")
        return if @movieYear == "exit"

        # Get the full movie with the title and year specified.
        theMovie = @crud.search_movie_with_year(@movieTitle, @movieYear)

        @msgBox.printSuccess("Movie successfully retrieved! Here is the data:", 0.5)
        @display.displayMovie(theMovie)
# =end
        # Ask them to choose which field they would like to update.
        updateTag = @prompt.select("Which tag would you like to update?", cycle: true) do |menu|
            menu.choice 'Title', 1
            menu.choice 'Year', 2
            menu.choice 'Ranking', 3
            menu.choice 'Directors', 4
            menu.choice 'Actors', 5
            menu.choice 'Genres', 6
            menu.choice 'Score', 7
            menu.choice 'Comment', 8
            menu.choice 'Exit', 9
        end

        if updateTag == 9
            return
        end

        # Now we ask the user for new data to replace the old data.
        case updateTag
        when 1
            newTitle = @msgBox.allCaps(@msgBox.getString("Enter the new 'title'.."))
            return if newTitle == "exit" 

            # Old data, with year, tag, new data
            @crud.update(@movieTitle, @movieYear, "title", newTitle)
            @msgBox.printSuccess("Movie has been successfully updated", 1.8)
            #Now we should be able to find with the new title

            getUpdatedMovie = @crud.search_movie_with_year(newTitle, @movieYear)
            @display.displayMovie(getUpdatedMovie)

            puts "Press Enter to continue"
            any = gets
            return
        when 2
            newYear = @msgBox.getInteger("Enter the new 'year'..")
            return if newYear == "exit"

            # Old data, with year, tag, new data
            @crud.update(@movieTitle, @movieYear, "year", newYear)
            @msgBox.printSuccess("Movie has been successfully updated", 1.8)            #Now we should be able to find with the new title

            getUpdatedMovie = @crud.search_movie_with_year(@movieTitle, newYear)
    
            # flattendData = Hash[*getUpdatedMovie.flatten]
            @display.displayMovie(getUpdatedMovie)

            puts "Press Enter to continuey"
            any = gets
            return
        when 3
            newRanking = @msgBox.allCaps(@msgBox.getString("Enter the new 'ranking'"))
            return if newRanking == "exit" 

            # Old data, with year, tag, new data
            @crud.update(@movieTitle, @movieYear, "ranking", newRanking)
            @msgBox.printSuccess("Movie has been successfully updated", 1.8)
            #Now we should be able to find with the new title

            getUpdatedMovie = @crud.search_movie_with_year(@movieTitle, @movieYear)
            @display.displayMovie(getUpdatedMovie)

            puts "Press Enter to continue"
            any = gets
            return
        when 4
            directorsArray = @msgBox.getStringArray("Enter the new 'directors'")
            if directorsArray.include?("Exit")
                @msgBox.printWarning("Exiting the program...", 2)
                return
            end

            @crud.update(@movieTitle, @movieYear, "directors", directorsArray)
            @msgBox.printSuccess("Movie has been successfully updated", 1.8)
        
            getUpdatedMovie = @crud.search_movie_with_year(@movieTitle, @movieYear)
            @display.displayMovie(getUpdatedMovie)

            puts "Press Enter to continue"
            any = gets
            return
        when 5
            actorsArray = @msgBox.getStringArray("Enter the new 'actors'")
            if actorsArray.include?("Exit")
                @msgBox.printWarning("Exiting the program...", 2)
                return
            end

            @crud.update(@movieTitle, @movieYear, "actors", actorsArray)
            @msgBox.printSuccess("Movie has been successfully updated", 1.8)
        
            getUpdatedMovie = @crud.search_movie_with_year(@movieTitle, @movieYear)
            @display.displayMovie(getUpdatedMovie)
            puts "Press Enter to continue"
            any = gets
            return
        when 6
            genresArray = @msgBox.getStringArray("Enter the new 'genres'")
            if genresArray.include?("Exit")
                @msgBox.printWarning("Exiting the program...", 2)
                return
            end

            @crud.update(@movieTitle, @movieYear, "genres", genresArray)
            @msgBox.printSuccess("Movie has been successfully updated", 1.8)
        
            getUpdatedMovie = @crud.search_movie_with_year(@movieTitle, @movieYear)
            @display.displayMovie(getUpdatedMovie)

            puts "Press Enter to continue"
            any = gets
            return
        when 7
            newScore = @msgBox.getInteger("Enter the new 'score'..")
            return if newScore == "exit"

            @crud.update(@movieTitle, @movieYear, "reviewScore", newScore)
            @msgBox.printSuccess("Movie has been successfully updated", 1.8)            #Now we should be able to find with the new title

            getUpdatedMovie = @crud.search_movie_with_year(@movieTitle, @movieYear)
    
            @display.displayMovie(getUpdatedMovie)

            puts "Press Enter to continue"
            any = gets
            return
        when 8
            newComment = @msgBox.getString("Enter the new 'Comment'..")
            return if newComment == "exit" 

            # Old data, with year, tag, new data
            @crud.update(@movieTitle, @movieYear, "reviewComment", newComment)
            @msgBox.printSuccess("Movie has been successfully updated", 1.8)
            #Now we should be able to find with the new title

            getUpdatedMovie = @crud.search_movie_with_year(@movieTitle, @movieYear)
            @display.displayMovie(getUpdatedMovie)

            puts "Press Enter to continue"
            any = gets
            return
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