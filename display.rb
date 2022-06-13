module Display

KING = ["\u2654", "\u265A"]
QUEEN = ["\u2655", "\u265B"]
ROOK = ["\u2656", "\u265C"]
BISHOP = ["\u2657", "\u265D"]
KNIGHT = ["\u2658", "\u265E"] 
PAWN = ["\u2659", "\u265F"]
NONE = [" ", " "]

    def Display.draw(board)
        for r in 0..7 do
            row = []
            for c in 0..7 do
                row << background(r^c, board[r][c])
            end
            row <<  background(1, [" ", " "])
            puts row.join(" ")
        end
    end

    def Display.background(position, piece)
        if (position & 1 == 0)
            return "\e[47m\e[30m" + piece[0] 
        else 
            return"\e[40m\e[37m" + piece[1]
        end
    end
end 

class Test
    include Display
    @base_row = [ROOK, KNIGHT, BISHOP, QUEEN, KING, BISHOP, KNIGHT, ROOK]
    @pawn_row = [PAWN]*8
    @empty_row = [NONE]*8

    def Test.start
        Display.draw([@base_row.map(&:reverse)] + [@pawn_row.map(&:reverse)] + [@empty_row]*4 + [@pawn_row] + [@base_row])
    end
end

Test.start
