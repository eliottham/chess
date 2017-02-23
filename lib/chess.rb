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
		if player.king.checkmate?(@board) == true
			return puts "Checkmate! #{enemy.color.capitalize} is the winner!"
		else
			if player.king.safe_at?(player.king.position, @board) == false
				@turn += 1 if player.king_command == true
				game
			else
				@turn += 1 if player.command == true
				game
			end
		end
	end
end
		
	
game = Chess.new