require_relative "piece"
class Bishop < Piece
	def set_symbol
		@color == "white" ? @symbol = "\u2657".encode('utf-8') : @symbol = "\u265D".encode('utf-8')
	end

	def possible_moves
		choices = Array.new
		up_right_path.each do |square|
			choices << square
		end
		up_left_path.each do |square|
			choices << square
		end
		bot_right_path.each do |square|
			choices << square
		end
		bot_left_path.each do |square|
			choices << square
		end
		return choices
	end
end