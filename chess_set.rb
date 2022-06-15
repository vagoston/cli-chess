require './board.rb'
require './pieces.rb'


class ChessSet
attr_reader :history

    def initialize 
        @board = Board.new
        @history = @board.history
        base_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        pawn_row = [Pawn]*8
        add_white(base_row, 1)
        add_white(pawn_row, 2)
        add_black(pawn_row, 7)
        add_black(base_row, 8)
    end

    def at(*args)
        @board.on(*args)
    end

    private

    def add(color, array, row_index)
        array.each_with_index do |piece, column_index| 
            position = Position.new(("A".ord + column_index).chr + (row_index).to_s)
            @board.place(position, piece.new(color, @board, position))
        end
    end

    def add_white(*args)
        add(Color::WHITE, *args)
    end
    
    
    def add_black(*args)
        add(Color::BLACK, *args)
    end
end