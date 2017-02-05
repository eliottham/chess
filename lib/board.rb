class Board
	attr_accessor :board
	def initialize
		@board = Array.new(8)
		for i in 0..8
			@board[i] = Array.new(8)
			for j in 0..8
				@board[i][j] = nil
			end
		end
	end
end


