Dir["./pieces/*.rb"].each { |file| require file }
class Player
	attr_reader :color, :king, :threat, :options

	def initialize(color, board)
		@color = color
		@board = board
	end

	def pieces_on_board
		@team = Array.new
		@enemy_team = Array.new
		for x in 0..7
			for y in 0..7
				@team << @board.square[x][y] if @board.square[x][y].class != Blank and @board.square[x][y].color == @color
				@enemy_team << @board.square[x][y] if @board.square[x][y].class != Blank and @board.square[x][y].color != @color
				@king = @board.square[x][y] if @board.square[x][y].class == King and @board.square[x][y].color == @color
				@enemy_king = @board.square[x][y] if @board.square[x][y].class == King and @board.square[x][y].color != @color
			end
		end
	end

	def king_safe_at?(position=@king.position)
		@threat = Array.new
		@enemy_team.each do |piece|
			if piece.possible_moves.include?(position) and piece.legal_move?(position, @board)
				@threat << piece
			end
		end
		return true if @threat.empty?
		return false
	end

	def king_options
		@options = @king.potential_moves(@threat, @board)
		@options.delete_if{ |position| king_safe_at?(position) == false }
		@options.delete_if{ |position| @king.legal_move?(position, @board) == false }
		@options.delete_if{ |position| @king.can_reach?(position) == false }
	end

	def king_command
		king_options
		puts "#{@color.capitalize}'s King is in check!"
		puts "Enter the square you want your King to move."
		@destination = user_parse(gets.chomp)
		if @destination == false
			puts "Invalid input. Try again"
			king_command
		end
		if !@options.include?(@destination)
			puts "You cannot move your King there!. Try again."
			king_command
		end
		@board.move(@initial, @destination)
	end

	def command
		puts "#{@color.capitalize} turn."
		puts "Enter the square of the piece you want to move:"
		@initial = user_parse(gets.chomp)
		if @initial == false
			puts "Invalid input. Try again"
			command
		end
		puts "Enter the square you want the piece to move to: (Type 'b' to go back)"
		@destination = user_parse(gets.chomp)
		if @destination == false or @destination == "b"
			puts "Invalid input. Try again" if @destination == false
			command
		end
		return puts "You don't have a piece here! Try again." if @board.object_at(@initial).color != @color
		return puts "Illegal move! Try again." if @board.object_at(@initial).legal_move?(@destination, @board) == false
		if @board.object_at(@initial) == @king
			if !@options.include?(@destination)
				puts "You cannot move your King there!. Try again."
				command
			end
		end
		@board.move(@initial, @destination)
	end

	def user_parse(string)
		letter_hash = {a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7}
		x = string[0]
		y = string[1]
		return "b" if string == "b"
		return false if string.length != 2
		return false if /[a-h]/.match(x) == nil or /[1-8]/.match(y) == nil
		x = letter_hash[x.to_sym]
		y = y.to_i - 1
		return [x, y]
	end
end
