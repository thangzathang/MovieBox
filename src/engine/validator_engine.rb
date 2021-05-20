require_relative "crud_engine"

class Validator 

    def initialize
        @crud = Crud.new
    end

    def checkExisting(movieTitle, movieYear)
        # Get the movie
        movie = @crud.search_movie(movieTitle)
        if movie == "Not Found"
            return false
        else
            # Check against the year
            if movie[:year] == movieYear
                return movie
            end
        end
    end


end