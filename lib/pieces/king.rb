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

	def potential_moves(threat, board)
		reach = Array.new
		threat.each do |piece|
			reach << piece.position
			temp = piece.possible_moves & possible_moves
			temp.each do |position|
				reach << position
			end
		end
		reach = reach.compact
		reach.delete_if{ |destination| legal_move?(destination, board) == false }
		threat.each do |piece|
			reach.delete_if{ |destination| piece.legal_move?(destination, board) == true }
		end
		return reach
	end

	def path(destination)
		path = Array.new
		path << destination
	end
end