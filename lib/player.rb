Dir["./pieces/*.rb"].each { |file| require file }
class Player
	attr_reader :color

	def initialize(color)
		@color = color
	end

	def pieces(board)
		team = Array.new
		for x in 0..7
			for y in 0..7
				team << board.square[x][y] if board.square[x][y] != nil and board.square[x][y].color == @color
			end
		end
		return team.compact
	end

	def enemy_king(board)
		for x in 0..7
			for y in 0..7
				return board.square[x][y] if board.square[x][y].class == King and board.square[x][y].color != @color
			end
		end
	end

	def king(board)
		for x in 0..7
			for y in 0..7
				return board.square[x][y] if board.square[x][y].class == King and board.square[x][y].color == @color
			end
		end
	end
end