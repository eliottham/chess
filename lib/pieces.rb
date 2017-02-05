#Unicode symbol color inverted because terminal is white on black
class Piece
	def canReach?(destination)
		if self.possibleMoves.include?(destination)
			return true
		end
	end
end

class Pawn < Piece
	attr_reader :color, :symbol
	attr_accessor :position

	def initialize(color, position)
		@color = color
		@position = position
		@symbol = "\u265F".encode('utf-8') if color == "white"
		@symbol = "\u2659".encode('utf-8') if color == "black"
		@offset = [[1, 0], [1, 1], [1, -1]]
	end

	def possibleMoves
		choices = Array.new
		@offset.each do |offset|
			if @color == "white"
				choices << [position[0] + offset[0], position[1] + offset[1]]
			else 
				choices << [position[0] - offset[0], position[1] + offset[1]]
			end
		end
		choices << [position[0] + 2, @position[1]] if @position[0] == 1 && @color == "white"
		choices << [position[0] - 2, @position[1]] if @position[0] == 6 && @color == "black"
		return choices.select { |p| (0..7).include?(p[0]) && (0..7).include?(p[1]) }
	end
end
