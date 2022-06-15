module Display

    public
    def Display.draw(set)
        puts add_frame(add_fields(set)).reverse.join("\n")
    end

    private
    def Display.add_fields(set)
        fields = []
        for r in (1..8).to_a do
            row = []
            for c in ("A".."H").to_a do
                position = Position.new(c + r.to_s)
                piece = set.at(position)
                chars = piece.nil? ? [" ", " "] : piece.display
                row << background(r^c.ord, chars)
            end
            fields << (row.join(" ") << " ")
        end
        fields
    end

    def Display.add_frame(rows)
        full_set = []
        edge_color = "\e[100m\e[97m"
        letters = edge_color + ("A".."H").to_a.join(" ") + " "
        [letters,* rows, letters].each_with_index do | row, index|
            edge = edge_color + " " + (index.between?(1,8) ? index.to_s : " ") + " "
            full_set << " " + edge + row + edge + "\e[0m "
        end
        full_set
    end

    def Display.background(position, piece)
        if (position & 1 == 1)
            return "\e[107m\e[30m" + piece[0]
        else 
            return"\e[40m\e[97m" + piece[1]
        end
    end
end 
