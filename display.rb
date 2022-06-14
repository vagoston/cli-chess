module Display

KING = ["\u2654", "\u265A"]
QUEEN = ["\u2655", "\u265B"]
ROOK = ["\u2656", "\u265C"]
BISHOP = ["\u2657", "\u265D"]
KNIGHT = ["\u2658", "\u265E"] 
PAWN = ["\u2659", "\u265F"]
NONE = [" ", " "]

    def Display.draw(board)
        puts add_frame(add_fields(board)).join("\n")
    end

    def Display.add_fields(board)
        fields = []
        for r in 0..7 do
            row = []
            for c in 0..7 do
                row << background(r^c, board[r][c])
            end
            fields << (row.join(" ") << " ")
        end
        fields
    end

    def Display.add_frame(rows)
        full_board = []
        edge_color = "\e[100m\e[97m"
        letters = edge_color + ("A".."H").to_a.join(" ") + " "
        [letters,* rows, letters].reverse.each_with_index do | row, index|
            edge = edge_color + " " + (index.between?(1,8) ? index.to_s : " ") + " "
            full_board << " " + edge + row + edge + "\e[0m "
        end
        full_board
    end

    def Display.background(position, piece)
        if (position & 1 == 0)
            return "\e[107m\e[30m" + piece[0]
        else 
            return"\e[40m\e[97m" + piece[1]
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
