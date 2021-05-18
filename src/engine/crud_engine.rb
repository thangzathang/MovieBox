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

    def delete(movie)
        @movies.delete_if { |movieObj| movieObj[:title] == movie }

        # Save the data
        save_data()
    end

    def update(title, tag, newData)
        newMovieObj = search_movie(title)
    
        # Delete the old movie with old data
        delete(title)

        # Overwrite the old data
        newMovieObj[tag.to_sym] = newData

        # Save -  it will hard save in this method
        save(newMovieObj)
    end

end