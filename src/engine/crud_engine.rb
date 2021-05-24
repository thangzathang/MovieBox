# This class WILL NOT handle pretty
# THis class will simply GET info and CONNECT to json.

require "json"

class Crud 
    def initialize
        @file_path = "../data/movies.json"
        @movies = []
        load_data()
    end 

    def save(movie)
        # Add to the temp local array.
        load_data()
        add_movie(movie)
        save_data()
    end

    def load_data
        # puts "Data loaded"
        data = JSON.parse(File.read("../data/movies.json"))
        # puts data
        @movies = data.map do |movie|
            movie.transform_keys(&:to_sym)
        end
    rescue Errno::ENOENT
        File.open(@file_path, 'w+')
        File.write(@file_path, [])
        retry
    end
    
    def save_data()
        File.write(@file_path, @movies.to_json)
    end

    def clear_data()
        File.open(@file_path, 'w') {|file| file.truncate(0) }
    end
    
    def add_movie(movie)
        @movies << movie
    end    

    def get_movies
        load_data()
        return @movies
    end

    def search_movie(movie)
        found = @movies.find { |movieObj| movieObj[:title] == movie }
        if found
            return found
        else 
            return "Not Found" 
        end
    end

    def search_movie_with_year(movie, year)
        found = @movies.find { |movieObj| 
            movieObj[:title] == movie && movieObj[:year] == year } 
        if found
            return found
        else 
            return "Not Found" 
        end
    end

    def search_movie_by_rating(score)
        # the array of movies need a score higher than this
        movies = @movies.select { |movieObj| 
            movieObj[:reviewScore] >= score
        }
        return movies
    end

    def search_movie_by_args_array(input, args)
        copyArgs = args.to_sym
        found = @movies.select { |movieObj| 
            movieObj[copyArgs].include?(input)
        }
        if found
            return found
        else 
            return "Not Found" 
        end
    end

    def search_movie_by_args(input, args)
        copyArgs = args.to_sym
        found = @movies.select { |movieObj| 
            movieObj[copyArgs] == input
        }
        if found
            return found
        else 
            return "Does Not Exist" 
        end
    end

    def delete(movieTitle, year)
        @movies.delete_if { |movieObj| 
            movieObj[:title] == movieTitle && movieObj[:year] == year }
        # Save the data
        save_data()
    end

    def update(title, year, tag, newData)
        newMovieObj = search_movie_with_year(title, year)
    
        # Delete the old movie with old data
        delete(title, year)

        # Overwrite the old data
        newMovieObj[tag.to_sym] = newData

        # Save -  it will hard save in this method
        save(newMovieObj)
    end

end