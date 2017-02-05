require_relative "piece"
class Queen < Piece
	def set_symbol
		@color == "white" ? @symbol = "\u2655".encode('utf-8') : @symbol = "\u265B".encode('utf-8')
	end

	def possible_moves
		choices = Array.new
		horizontal_path.each do |square|
			choices << square
		end
		vertical_path.each do |square|
			choices << square
		end
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

q = Queen.new("black", [5,1])
print q.possible_moves