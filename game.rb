require './chess_set.rb'
require './display.rb'

class Game
    include Color

    def initialize(set=ChessSet.new, next_move=WHITE)
        @set = set
        @next_move = next_move
        Display::draw(set)
    end

    def at(*args)
        @set.at(*args)
    end        

    def move(from, to)
        from, to = [from, to].map{|p| Position.new(p)}
        piece = at(from)
        if piece&.color == @next_move and piece&.valid_move?(to)
            at(from).place(to)
            Display::draw(@set)
            @next_move *= -1 
        end
    end

    def show_history
        history = @set.history
        history.each_with_index do |step, index|
            puts "#{index + 1}: #{step[0]} - #{step[1]}"
        end
    end

    def start
        loop do 
            input = gets.chomp
            case input
            when "history" then show_history
            else 
                if (0 == (input =~ /^[a-zA-Z][1-8] [a-zA-Z][1-8]$/))
                    move(*input.split)
                else 
                    puts "ERROR"
                end
            end
        end
    end
end
