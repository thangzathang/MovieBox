# External Library
require "Rainbow"
require "tty-prompt"
require "artii"

class MessageBox

    def initialize
        puts "Message Box is live!"
        @prompt = TTY::Prompt.new
    end

    def print(message, timer=0)
        puts "\n"
        puts Rainbow("#{message}").mediumblue
        sleep(timer)
    end

    def printWarning(message, timer=0)
        puts "\n"
        puts Rainbow("#{message}").red
        sleep(timer)
    end

    def printProcessing(message, timer=0)
        puts "\n"
        puts Rainbow("#{message}").navyblue
        sleep(timer)
    end

    def allCaps(arr)
        return arr.split.map(&:capitalize).join(' ')
    end

    def printSuccess(message, timer=0)
        puts "\n"
        puts Rainbow("#{message}").darkgreen
        sleep(timer)
    end

    def get(question)
        print(question)
        obj = gets
        return obj
    end

    def getString(question)
        @string = ""
        @string = get(question).chomp
        while @string.chomp.empty?
            printWarning("Must be a string and not left blank!")
            @string = get(question).chomp
        end
        return @string
    end

    def getSlider()
        puts "\n"
        value = @prompt.slider("Review", min: 0, max: 100, step: 5)
        return value
    end

=begin
    # Validating to make sure number only bit tricky
    def getStringOnly(question)
        @string = ""
        @string = Integer(get(question)) rescue nil
        puts @string.class
        while @string.chomp.empty? || @string.class != String
            printWarning("Must be a string and not left blank!")
            @string = gets
            puts @string.class
        end
        return @string
    end
=end

    def getStringArray(message)
        @array = []
        splitArr = getString(message).strip.split(",")
        splitArr.each do |item|
            #puts "Item: #{allCaps(item)}"
            @array.push(allCaps(item))
        end
        
        return @array
        # use get string 
        # Check if com=ntains commas
        # IF contains commas we split it up
        # add the names in an array
    end

    def getInteger(question)
        # Create Empty String
        year = ""
        # Use the method we already made above to get input
        year = get(question)
        # Check if it is 'exit' - if it is return it.
        if year.chomp == "exit"
            return "exit"
        end

        @yearCopy = year.to_i
        # This is a 2 hour wasted bug to find lol, changing year.to_i does not make year.class into INTEGER like we want.
        # We must make a copy so the new yearCopy has class of integer

        # Make sure it's not empty - but cant do .empty? on an integer.
        # SO keep tow copies to get the best of both worlds but the final @yearCopy is the one we send back.
        while @yearCopy.to_i < 0 || year.chomp.empty?
            printWarning("Must be a Positive Number and not Blank")
            year = get(question)
            if year.chomp == "exit"
                return "exit"
            end
            @yearCopy = year.to_i
        end

        return @yearCopy
    end

end