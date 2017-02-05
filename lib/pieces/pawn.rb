require_relative "piece"
class Pawn < Piece
	def set_symbol
		@color == "white" ? @symbol = "\u2659".encode('utf-8') : @symbol = "\u265F".encode('utf-8')
	end

	def possible_moves
		choices = Array.new
		offset = [[0, 1], [1, 1], [-1, 1]]
		offset.each do |offset|
			if @color == "white"
				choices << [@position[0] + offset[0], @position[1] + offset[1]]
			else 
				choices << [@position[0] + offset[0], @position[1] - offset[1]]
			end
		end
		choices << [@position[0], @position[1] + 2] if @position[0] == 1 && @color == "white"
		choices << [@position[0], @position[1] - 2] if @position[0] == 6 && @color == "black"
		return choices.select{ |p| (0..7).include?(p[0]) && (0..7).include?(p[1]) }
	end

	def path(destination)
		path = Array.new
		if destination[1] == @position[1] + 2 && @color == "white"
			path << [@position[0], @position[1] + 1] << destination
		elsif destination[1] == @position[1] - 2 && @color == "black"
			path << [@position[0], @position[1] - 1] << destination
		else
			path << destination
		end
		return path
	end
end