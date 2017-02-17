require_relative "player"
require_relative "board"
Dir["./pieces/*.rb"].each { |file| require file }
class Chess
	attr_reader :board, :p1
	def initialize
		@p1 = Player.new("white")
		@p2 = Player.new("black")
		@board = Board.new
		@turn = 0
		game
	end 

	def check(player)
		@check_pieces = Array.new
		enemy_king = player.enemy_king(@board)
		player.pieces(@board).each do |piece|
			if piece.can_reach?(enemy_king.position) and @board.legal_move?(piece.position, enemy_king.position) == true
				@check_pieces << piece
			end
		end
		@check_pieces = @check_pieces.compact
	end

	def check_response(player)
		king = player.king(@board)
		print king.legal_moves(@board, @check_pieces)
	end
=begin		@check_pieces.each do |piece|
			legal_moves << piece.possible_moves & king.possible_moves
		end
		if legal_moves.compact.empty?
			player.color == "white" ? winner = "Black" : winner = "White"
			puts "Checkmate! #{winner} is the winner!"
			return
		end
		@initial_square = king.position
		puts "#{player.color.capitalize} turn."
		puts "Enter the square you want your king to move to:"
		@destination_square = user_parse(gets.chomp)
		if legal_moves.any?{ |position| position == @destination_square }
			if @board.move(@initial_square, @destination_square) == true
				@board.move(@initial_square, @destination_square)
				@turn += 1
				game
			end
		end
		puts "Illegal move! Try again."
		check_response(player)
	end
=end		





	def user_parse(string)
		letter_hash = {a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7}
		x = string[0]
		y = string[1]
		return false if string.length != 2
		return false if /[a-h]/.match(x) == nil or /[1-8]/.match(y) == nil
		x = letter_hash[x.to_sym]
		y = y.to_i - 1
		return [x, y]
	end

	def command(player)
		puts "#{player.color.capitalize} turn."
		puts "Enter the square of the piece you want to move:"
		@initial_square = user_parse(gets.chomp)
		puts "Enter the square you want the piece to move to:"
		@destination_square = user_parse(gets.chomp)
		if @initial_square == false or @destination_square == false
			puts "Invalid input. Try again."
			command(player)
		end
		if @board.object_at(@initial_square).class == Blank
			return puts "There is no piece here! Try again."
		else
			return puts "This is not your piece! Try again." if @board.object_at(@initial_square).color != player.color
		end
		return puts "Illegal move! Try again." if @board.move(@initial_square, @destination_square) == false
		@turn += 1
	end

	def game
		@turn % 2 == 0 ? player = @p1 : player = @p2
		@board.display
		command(player)
		check(player)
		if !@check_pieces.empty?
			@turn % 2 == 0 ? player = @p1 : player = @p2
			@board.display
			check_response(player)
		end
		game
	end
end
g = Chess.new

