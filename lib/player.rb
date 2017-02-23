Dir["./pieces/*.rb"].each { |file| require file }
class Player
	attr_reader :color

	def initialize(color, board)
		@color = color
		@board = board
	end

	def king
		@board.square.each do |x|
			for i in 0...@board.square.length
				@king = x[i] if x[i].class == King and x[i].color == @color
			end
		end
		return @king
	end

	def king_command
		king
		puts "Check! #{@color.capitalize} must protect their King!"
		puts "Enter the square of the piece you want to move:"
		@initial = user_parse(gets.chomp)
		return puts "Invalid input. Try again." if @initial == false
		puts "Enter the square you want the piece to move to: (Type 'b' to go back)"
		@destination = user_parse(gets.chomp)
		return false if @destination == "b"	
		return puts "Invalid input. Try again." if @destination == false
		return puts "You don't have a piece here! Try again." if @board.object_at(@initial).color != @color
		return puts "Illegal move! Try again." if @board.object_at(@initial).legal_move?(@destination, @board) == false
		temp_init = @board.object_at(@initial)
		temp_dest = @board.object_at(@destination)
		@board.move(@initial, @destination)
		if @king.safe_at?(@king.position, @board) == false
			@board.square[@initial[0]][@initial[1]] = temp_init
			@board.square[@destination[0]][@destination[1]] = temp_dest
			return puts "Illegal move! Your King is still in danger! Try again."
		end
		return true
	end

	def command
		puts "#{@color.capitalize}'s turn."
		puts "Enter the square of the piece you want to move:"
		@initial = user_parse(gets.chomp)
		return puts "Invalid input. Try again." if @initial == false
		puts "Enter the square you want the piece to move to: (Type 'b' to go back)"
		@destination = user_parse(gets.chomp)
		return false if @destination == "b"	
		return puts "Invalid input. Try again." if @destination == false
		return puts "You don't have a piece here! Try again." if @board.object_at(@initial).color != @color
		return puts "Illegal move! Try again." if @board.object_at(@initial).legal_move?(@destination, @board) == false
		@board.move(@initial, @destination)
		return true
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