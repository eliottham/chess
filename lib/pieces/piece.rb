class Piece
	attr_reader :color, :symbol
	attr_accessor :position, :moved

	def initialize(color, position)
		@color = color
		@position = position
		@moved = false
		set_symbol
	end

	def can_reach?(destination)
		return possible_moves.include?(destination)
	end

	def horizontal_path(destination=nil)
		path = Array.new
		square = @position
		until square[0] > 6
			square = [square[0] + 1, square[1]]
			path << square
			return path if square == destination
		end
		square = @position
		until square[0] < 1
			square = [square[0] - 1, square[1]]
			path << square
			return path if square == destination
		end
		return path
	end

	def vertical_path(destination=nil)
		path = Array.new
		square = @position
		until square[1] > 6
			square = [square[0], square[1] + 1]
			path << square
			return path if square == destination
		end
		square = @position
		until square[1] < 1
			square = [square[0], square[1] - 1]
			path << square
			return path if square == destination
		end
		return path
	end

	def up_right_path(destination=nil)
		path = Array.new
		square = @position
		until square[0] > 6 or square[1] > 6
			square = [square[0] + 1, square[1] + 1]
			path << square
			return path if square == destination
		end
		return path
	end

	def up_left_path(destination=nil)
		path = Array.new
		square = @position
		until square[0] < 1 or square[1] > 6
			square = [square[0] - 1, square[1] + 1]
			path << square
			return path if square == destination
		end
		return path
	end

	def bot_right_path(destination=nil)
		path = Array.new
		square = @position
		until square[0] > 6 or square[1] < 1
			square = [square[0] + 1, square[1] - 1]
			path << square
			return path if square == destination
		end
		return path
	end

	def bot_left_path(destination=nil)
		path = Array.new
		square = @position
		until square[0] < 1 or square[1] < 1
			square = [square[0] - 1, square[1] - 1]
			path << square
			return path if square == destination
		end
		return path
	end

	def path(destination)
		return horizontal_path(destination) if horizontal_path(destination).include?(destination)
		return vertical_path(destination) if vertical_path(destination).include?(destination)
		return up_right_path(destination) if up_right_path(destination).include?(destination)
		return up_left_path(destination) if up_left_path(destination).include?(destination)
		return bot_right_path(destination) if bot_right_path(destination).include?(destination)
		return bot_left_path(destination) if bot_left_path(destination).include?(destination)
	end
end
