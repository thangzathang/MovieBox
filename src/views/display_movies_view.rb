# External Library
require "Rainbow"
require "tty-prompt"
require "artii"
require 'terminal-table'

# Local files
require_relative "../engine/validator_engine"
require_relative "../engine/crud_engine"
require_relative "../utilities/message_box"

# This class is simply to display the movies
# Use the tty-table or the terminal table
# Make it pretty

class DisplayMovie
    def initialize
        @valdiator = Validator.new
        @prompt = TTY::Prompt.new
        @arrti = Artii::Base.new :font => 'slant'
        @crud = Crud.new
        @msgBox = MessageBox.new
    end

    def run
        # Infinite Loop until user quits the display
        loop do 
            system("clear")
            puts @arrti.asciify("Display Movie!")

            input = @prompt.select('Show by filter', cycle: true) do |menu|
                menu.choice 'Show all',  1
                menu.choice 'Filter by Title', 2
                menu.choice 'Filter by Review Score', 3
                menu.choice 'Filter by Genre', 4
                menu.choice 'Filter by Actor', 5
                menu.choice 'Filter by Director', 6
                menu.choice 'Exit', 7
            end

            if input == 7
                return
            end

            case input 
            when 1
                showAll()
            when 2
                filterByTitle()
            when 3
                filterByReview()
            when 4
                # Needs to print all
                filterByGenres()
            when 5
                filterByActors()
            when 6
                # This is fixed!
                filterByDirectors()
            end
        end
    end

    def filterByDirectors()
        directorsArray = @msgBox.getStringArray("Input director's name")
        if directorsArray.include?("Exit")
            @msgBox.printWarning("Exiting the program...", 2)
            return
        end

        movieArr = []

        # Only allows one director to all movies.
        directorsArray.each do |directors|
            movieArr = @crud.search_movie_by_args_array(directors, "directors")
        end
        
        # Try to see wht this code does. Allows for multiple People
        # directorsArray.each do |directors|
        #     movieArr << @crud.search_movie_by_args_array(directors, "directors")
        # end

        if movieArr.size == 0
            @msgBox.printWarning("Movie does not exist!", 1.8)
            return
        end

        movieArr.each do |movie|
            displayMovie(movie)
        end

        puts "\n\nPress enter to continue..."
        enter = gets
        return
    end

    def filterByActors()
        actorsArray = @msgBox.getStringArray("Input actor's/actress's name")
        if actorsArray.include?("Exit")
            @msgBox.printWarning("Exiting the program...", 2)
            return
        end

        movieArr = []

        actorsArray.each do |actors|
            movieArr = @crud.search_movie_by_args_array(actors, "actors")
        end

        if movieArr.size == 0
            @msgBox.printWarning("Movie does not exist!", 1.8)
            return
        end

        movieArr.each do |actor|
            # printMovie = Hash[*movie.flatten]
            # displayMovie(printMovie)
            displayMovie(actor)
        end

        puts "\n\nPress enter to continue..."
        enter = gets
        return
    end

    def filterByGenres()
        genresArray = @msgBox.getStringArray("Input movie genre you want to see")
        if genresArray.include?("Exit")
            @msgBox.printWarning("Exiting the program...", 2)
            return
        end

        movieArr = []

        genresArray.each do |genre|
            movieArr = @crud.search_movie_by_args_array(genre, "genres")

            # Allows for multiple input - but problms
            # movieArr << @crud.search_movie_by_args_array(genre, "genres")
        end

        if movieArr.size == 0
            @msgBox.printWarning("Movie does not exist!", 1.8)
            return
        end

        # To avoid duplicate data
        # movieArr = movieArr.uniq

        movieArr.each do |movie|
            # displayMovie expects a hash.
            # take out the flatten and code WILL not work.


            # printMovie = Hash[*movie.flatten]
            # displayMovie(printMovie)
            displayMovie(movie)
        end

        puts "\n\nPress enter to continue..."
        enter = gets
        return

    end

    def filterByTitle()
        @msgBox.print("Filter By Name:")
        movieTitle = @msgBox.allCaps(@msgBox.getString("What is the name of the movie?"))
        return if movieTitle == "exit" 

        movieArr = @crud.search_movie_by_args(movieTitle, "title")

        if movieArr.size == 0
            @msgBox.printWarning("Movie does not exist!", 1.8)
            return
        end

        movieArr.each do |movie|
            displayMovie(movie)
        end

        puts "\n\nPress enter to continue..."
        enter = gets
        return
    end

    def filterByReview()
        @msgBox.print("Filter By Review Score:")
        movieScore = @msgBox.getInteger("What is the minium rating of the movie?")
        return if movieScore == "exit" 

        movieArr = @crud.search_movie_by_rating(movieScore)

        if movieArr.size == 0
            @msgBox.printWarning("Movie does not exist!", 1.8)
            return
        end

        movieArr.each do |movie|
            displayMovie(movie)
        end

        puts "\n\nPress enter to continue..."
        enter = gets
        return
    end

    def showAll()
        @movies = @crud.get_movies()

        if @movies.size == 0
            @msgBox.printWarning("There are no movies in the array!", 1.8)
            return
        end

        @movies.each do |movie|
            displayMovie(movie)
        end

        puts "Press Enter to Continue..."
        enter = gets
        return
    end

    def displayMovie(movie)
        table = Terminal::Table.new :style => {:width => 80}, :title => Rainbow(movie[:title]).darkred do |t|
            t << [ "Year", movie[:year]]
            t.add_separator 
            t << [ "Rank", movie[:ranking] ? movie[:ranking] : "No ranking"]
            t.add_separator 
            t << [ "Directors", movie[:directors] ? movie[:directors].join(', '): "N\\A" ]
            t.add_separator 
            t << [ "Actors", movie[:actors] ? movie[:actors].join(', ') : "N\\A" ]
            t.add_separator 
            t << [ "Genres", movie[:genres] ? movie[:genres].join(', ') : "N\\A" ]
            t.add_separator 
            t << [ "Score", movie[:reviewScore] ? movie[:reviewScore]: "N\\A" ]
            t.add_separator 
            t << [ "Comment", movie[:reviewComment] ? movie[:reviewComment] : "N\\A" ]
          end
          puts table        
    end

    def displayMovieInfo(movie)
        table = Terminal::Table.new  :style => {:width => 80}, :title => movie[:title] do |t|
            t << [ "Year", movie[:year]]
            t.add_separator 
            t << [ "Directors", movie[:directors] ? movie[:directors].join(', '): "N\\A" ]
            t.add_separator 
            t << [ "Actors", movie[:actors] ? movie[:actors].join(', ') : "N\\A" ]
          end
          puts table        
    end
    

    
end