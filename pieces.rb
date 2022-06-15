require '.\helper.rb'

module Color
    WHITE = 1
    BLACK = -1
end

class Piece
    include Color
    attr_reader :color

    def initialize(color, board, position)
        @color = color
        @board = board
        @position = position
        @moved = false
    end
    
    def valid_move?(from, to)
        false
    end

    def display
        @color == WHITE ? @chars : @chars.reverse
    end

    def place(to)
        raise InvalidMove unless valid_move?(to)
        @board.history << [@position, to]
        @board.place(@position, nil)
        @position = to
        @moved = true
        @board.place(to, self)
    end

end

class Pawn < Piece
    
    def initialize(*args)
        super
        @chars =  ["\u2659", "\u265F"]
    end

    def valid_move?(to)
        from = @position
        target_piece = @board.on(to)
        if target_piece.nil?
            if (from.column == to.column)
                return true if from.row + @color == to.row
                return true if !@moved and from.row + 2 * @color == to.row
            end
        end

        if (target_piece&.color != @color)
            return true if (distance(from.column, to.column) == 1 and from.row + @color == to.row)
        end

        if (@moved and 
            @board.on(@board.history.last.last).class == Pawn and 
            @board.history.last.last.column == to.column and 
            2 == distance(@board.history.last.last.row, @board.history.last.first.row))
            return true if (distance(from.column, to.column) == 1 and from.row + @color == to.row)
        end

        false
    end

    def place(to)
        from = @position
        if (@moved and 
            @board.on(@board.history.last.last).class == Pawn and 
            @board.history.last.last.column == to.column and 
            2 == distance(@board.history.last.last.row, @board.history.last.first.row) and
            distance(from.column, to.column) == 1 and from.row + @color == to.row)
        @board.place(@board.history.last.last, nil)
        end
        super
    end
end

class King < Piece
    def initialize(*args)
        super
                @chars = ["\u2654", "\u265A"]
end
end

class Queen < Piece
    def initialize(*args)
        super
         @chars = ["\u2655", "\u265B"]
    end
end

class Rook < Piece
    def initialize(*args)
        super
        @chars = ["\u2656", "\u265C"]
    end
end

class Bishop < Piece
    def initialize(*args)
        super
         @chars = ["\u2657", "\u265D"]
end
end

class Knight < Piece
    def initialize(*args)
        super
         @chars = ["\u2658", "\u265E"] 
end
end
