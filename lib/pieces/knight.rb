require_relative "piece"
class Knight < Piece
	def set_symbol
		@color == "white" ? @symbol = "\u2658".encode('utf-8') : @symbol = "\u265E".encode('utf-8')
	end

	def possible_moves
		choices = Array.new
		offset = [ [2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2] ]
		offset.each do |offset|
			choices << [@position[0] + offset[0], @position[1] + offset[1]]
		end
		return choices.select{ |p| (0..7).include?(p[0]) && (0..7).include?(p[1]) }
	end

	def path(destination)
		return destination
	end
end
