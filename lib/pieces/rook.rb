require_relative "piece"
class Rook < Piece
	def set_symbol
		@color == "white" ? @symbol = "\u2656".encode('utf-8') : @symbol = "\u265C".encode('utf-8')
	end

	def possible_moves
		choices = Array.new
		horizontal_path.each do |square|
			choices << square
		end
		vertical_path.each do |square|
			choices << square
		end
		return choices
	end
end