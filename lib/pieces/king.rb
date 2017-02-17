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
		return choices.delete_if{ |square| square == @position }
	end

	def legal_moves(board, check_pieces)
		illegal_moves = Array.new
		check_pieces.each do |piece|
			temp = piece.possible_moves & possible_moves
			temp.each do |position|
				illegal_moves << position
			end
		end
		choices = possible_moves - illegal_moves
		choices = choices.delete_if{ |target| board.legal_move?(@position, target) == false }
		return choices
	end

	def path(destination)
		path = Array.new
		path << destination
	end
end