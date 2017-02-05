require_relative "piece"
class King < Piece 
	def set_symbol
		@color == "white" ? @symbol = "\u2654".encode('utf-8') : @symbol = "\u265A".encode('utf-8')
	end

	def possible_moves
		choices = Array.new
		offset = [ [1, 0], [-1, 0], [1, 1], [-1, 1], [1, -1], [-1, -1], [0, 1], [0, -1] ]
		offset.each do |offset|
			choices << [@position[0] + offset[0], @position[1] + offset[1]]
		end
		return choices
	end

	def path(destination)
		path = Array.new
		path << destination
	end
end