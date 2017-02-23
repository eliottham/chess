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
		choices = choices.select{ |p| (0..7).include?(p[0]) && (0..7).include?(p[1]) }
		return choices.delete_if{ |square| square == @position }
	end

	def safe_at?(position, board)
		enemy_team = Array.new
		@team = Array.new
		board.square.each do |x|
			for i in 0...board.square.length
				if x[i].color != @color and x[i].class != Blank
					enemy_team << x[i]
				elsif x[i].color == @color and x[i].class != Blank and x[i].class != King
					@team << x[i]
				end
			end
		end
		@threat = Array.new
		enemy_team.each do |piece|
			if piece.legal_move?(position, board)
				@threat << piece
			end
		end
		return true if @threat.empty?
		return false
	end

	def legal_move?(destination, board)
		return false if !can_reach?(destination)
		return false if board.object_at(destination).color == @color
		return false if safe_at?(destination, board) == false
		return true
	end

	def checkmate?(board)
		return false if safe_at?(@position, board) == true
		options = possible_moves
		options.delete_if{ |position| legal_move?(position, board) == false }
		flag = 0

		@threat.each do |piece|
			path = piece.path(@position)
			path.each do |position|
				if @team.any?{ |team| team.legal_move?(position, board) } == true
					flag += 1
				end
			end
		end
		return false if flag != 0 or !options.empty?
		return true
	end
end