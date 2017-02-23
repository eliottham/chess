require_relative "player"
require_relative "board"
Dir["./pieces/*.rb"].each { |file| require file }
class Chess
	attr_reader :board, :p1, :p2
	def initialize
		@board = Board.new
		@p1 = Player.new("white", @board)
		@p2 = Player.new("black", @board)
		@turn = 0
		game
	end 

	def game
		@turn % 2 == 0 ? player = @p1 : player = @p2
		player == @p1 ? enemy = @p2 : enemy = @p1
		@board.display
		player.pieces_on_board
		if player.king_safe_at? == false
			if player.options == nil
				return puts "Checkmate! #{@enemy.color.capitalize} is the winner!"
			else
			player.king_command
			@turn += 1
			game
			end
		end
		player.command
		@turn += 1
		game
	end
end
		
	
g = Chess.new
#g.board.move([3, 1], [3, 3])
#g.board.move([2, 6], [2, 4])
#g.board.move([3, 3], [2, 4])
#g.board.move([3, 6], [3, 5])
#g.board.move([2, 4], [3, 5])
#g.board.move([3, 7], [3, 5])
##g.board.move([3, 0], [3, 5])
#g.board.move([3, 5], [3, 6])
##g.board.move([3, 6], [3, 7])
#g.p2.pieces_on_board
#g.board.display
#puts g.p2.king.can_reach?([3, 7])
#puts g.p2.king_safe_at?
#puts "x"
#print g.p2.king.legal_move?([3, 7], g.board)
#puts "x"
#print g.board.object_at([3, 7]).legal_move?([3, 7], g.board)
#puts g.p2.king.safe_moves(g.p2.threat, g.board).include?([3, 7])
#puts
#puts g.p2.king.legal_move?([5, 6], g.board)
#puts g.board.move_king([4, 7], [3, 7])
#g.board.display




