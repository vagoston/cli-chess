require './pieces.rb'
require './errors.rb'
require 'byebug'

class Position
    attr_reader :row
    attr_reader :column
    attr_reader :string
    def initialize(string) 
        @string = string
        letter, number = (String === string) ? string.split('') : string
        number = number&.to_i
        letter = letter&.upcase
        raise InvalidPosition.new unless number&.between?(1,8) and  letter&.between?('A','H')
        @row = number - 1
        @column = letter.ord - 'A'.ord
    end

    def to_s
        @string
    end
end


class Board
    attr_accessor :history

    def initialize
        @board = Array.new(8) {Array.new(8)}
        @history = []
    end

    def on(position)
        @board[position.row][position.column]
    end

    def place(position, piece)
        @board[position.row][position.column] = piece
    end

end
