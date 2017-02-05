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

	def path(destination)
		return horizontal_path(destination) if horizontal_path(destination).include?(destination)
		return vertical_path(destination) if vertical_path(destination).include?(destination)
	end
end


r = Rook.new("white", [1, 0])
puts r.symbol
print r.path([5, 0])