# External Library
require "Rainbow"
require "tty-prompt"
require "artii"
require "tty-box"

# Local files
require_relative "../engine/validator_engine"
require_relative "../engine/crud_engine"
require_relative "../utilities/message_box"

# This class is simply to get the information
# Pass validations 
# Create obj 
# Save obj to external by contacting crud

class AddMovie
    attr_reader :prompt

    def initialize
        @valdiator = Validator.new
        @prompt = TTY::Prompt.new
        @arrti = Artii::Base.new :font => 'slant'
        @crud = Crud.new
        @msgBox = MessageBox.new
        @validator = Validator.new 
    end

    def run
        # 1. Explain how to exit screen. 
        # 2. Get the name and year check if it already exists. 
        system("clear")
        puts @arrti.asciify("Add Movie!")

        movie = {}

        # Message box with colors
        @msgBox.print("You can exit questions by typing \'exit\' anytime.")

        # 1. Get Movie Title
        @movieTitle = @msgBox.allCaps(@msgBox.getString("What is the name of the movie?"))
        return if @movieTitle == "exit" 

        movie[:title] = @movieTitle

        # 2. Get Movie Year
        @movieYear = @msgBox.getInteger("What year was it released?")
        return if @movieYear == "exit"
        movie[:year] = @movieYear

        # Validation: Now check if the movie already exists using the title and year
        @msgBox.printProcessing("Checking for duplicates", 0.5)
        alreadyExists = @valdiator.checkExisting(@movieTitle, @movieYear)
        if alreadyExists
            @msgBox.printWarning("Movie already exists!")
            # Get the object and show when it was added!
            puts "Creadted #{alreadyExists[:title]} release #{alreadyExists[:year]}, at: {createdAt}"

            # Ask if they would like to add another one?
            @msgBox.print("You can always edit movie at the menu",3)
            return
        end
        @msgBox.printSuccess("No duplicates exists", 1.5)

        # 2.5. Get the Ranking(s)
        @msgBox.print("What is the ranking? S tier, A tier, B tier..etc ?")

        @movieRanking = @msgBox.getString("Type the ranking")
        
        if @movieRanking.include?("Exit")
            @msgBox.printWarning("Exiting the program...", 2)
            return
        end
        movie[:ranking] = @movieRanking

        # 3. Get the Director(s)
        @msgBox.print("Name of Director(s) [Seprated by commas ( , )]")
        @directorsArray = @msgBox.getStringArray("What is the name of the director(s)?")
        if @directorsArray.include?("Exit")
            @msgBox.printWarning("Exiting the program...", 2)
            return
        end
        movie[:directors] = @directorsArray

        # 4. Get the Actors(s)
        @msgBox.print("Name of Actor/Actress(s) [Seprated by commas ( , )]")
        @actorsArray = @msgBox.getStringArray("Who is it starring?")
        if @actorsArray.include?("Exit")
            @msgBox.printWarning("Exiting the program...", 2)
            return
        end
        movie[:actors] = @actorsArray

        # 5. Get the genres - tty-prompt multi select does not work on bash
        @msgBox.print("List Genres [Seprated by commas ( , )]")
        @genresArray = @msgBox.getStringArray("Input movie genres")
        if @genresArray.include?("Exit")
            @msgBox.printWarning("Exiting the program...", 2)
            return
        end
        movie[:genres] = @genresArray

        # 6. Get the review score with the tty-propmt slider.
        @msgBox.print("Rate movie from 0 - 100%")
        @movieReview = @msgBox.getSlider()
        movie[:reviewScore] = @movieReview

        # 7. Get the review comments, no more than 250 limit word counter.
        @movieReviewComment = @msgBox.getString("What is your movie review comment?")
        movie[:reviewComment] = @movieReviewComment

        box = TTY::Box.frame(
            align: :center, 
            padding: 2,
            border: :thick, 
            title: {top_left: " #{@movieTitle} ", bottom_right: " #{@movieReview} "}) do
                "#{@movieReviewComment}"
            end
        print box

        @msgBox.print("Press Enter key to continue...")
        any = gets

        box2 = TTY::Box.success("Successfully Saved").center(20)
        print box2

        # 8. Create a createdAt as a last field.

=begin
        puts "Who does it star?"
        staring = gets.chomp
        movie[:staring] = staring

        puts "What is your review? 1 - 10"
        review = gets.to_i
        movie[:review] = review
=end
       
        # 9. Save the movie object
        puts "Movie is saved to database!"
        @crud.save(movie)
        sleep(1.5)
    end

    
    
end