# This class WILL NOT handle pretty
# THis class will simply GET info and CONNECT to json.

require "json"

class Crud 
    def initialize
        @file_path = "./data/movies.json"
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
        
        data = JSON.parse(File.read("./data/movies.json"))
        # puts data
        @movies = data.map do |movie|
            movie.transform_keys(&:to_sym)
        end
    rescue Errno::ENOENT
        File.open(@file_path,'w')
        File.write(@file_path,[])
        # File.new(@file_path,'w+')
        # File.write(@file_path,'[]')
        retry
    end

    def clear_data()
        File.open(@file_path, 'w') {|file| file.truncate(0) }
    end
    
    def add_movie(movie)
        @movies << movie
    end    

    def save_data()
        File.write(@file_path, @movies.to_json)
    end

    def get_movies
        load_data()
        return @movies
    end

    def search_movie(movieTitle)
        found = @movies.find { 
            |movieObj| movieObj[:title] == movieTitle 
        }
        if found
            return found
        else 
            return "Not Found" 
        end
    end

# DEMO
# @movies is array of movies
    def search_movie_with_year(movie, year)
        found = @movies.find { |movieObj| 
            movieObj[:title] == movie && 
            movieObj[:year] == year 
        } 
        if found
            return found
        else 
            return "Not Found" 
        end
    end


    def search_movie_by_rating(score)
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
        # 1. Find the old movie with the title and year
        # 1.5 Make a copy of it
        newMovieObj = search_movie_with_year(title, year)
    
        #2. Delete the old movie with old data
        delete(title, year)

        # Overwrite the OLD COPIED DATA
        newMovieObj[tag.to_sym] = newData

        # Save -  it will hardcore save 
        save(newMovieObj)
    end

end