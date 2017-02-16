Dir["./pieces/*.rb"].each { |file| require file }
class Board
	attr_accessor :square
	def initialize
		@square = Array.new(8)
		for x in 0..7
			@square[x] = Array.new(8)
			for y in 0..7
				@square[x][y] = Blank.new([x, y])
			end
		end
		set_pieces
	end

	def set_pieces
		piece_classes = ["Rook", "Knight", "Bishop"]
		for i in 0..7
			@square[i][1] = Pawn.new("white", [i, 1])
			@square[i][6] = Pawn.new("black", [i, 6])
		end
		for i in 0..2
			j = 7 - i
			@square[i][0] = Kernel.const_get(piece_classes[i]).new("white", [i, 0])
			@square[j][0] = Kernel.const_get(piece_classes[i]).new("white", [j, 0])
			@square[i][7] = Kernel.const_get(piece_classes[i]).new("black", [i, 7])
			@square[j][7] = Kernel.const_get(piece_classes[i]).new("black", [j, 7])
		end
		@square[3][0] = Queen.new("white", [3, 0])
		@square[3][7] = Queen.new("black", [3, 7])
		@square[4][0] = King.new("white", [4, 0])
		@square[4][7] = King.new("black", [4, 7])
	end

	def display
		letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
		print "\n"
		for i in 0..7
			print "  #{letters[i]}"
		end
		print "\n"
		for y in (7).downto(0)
			print "#{y + 1} "
			for x in 0..7
				if @square[x][y].class != Blank
					print "#{@square[x][y].symbol}  "
				else
					print "#{letters[x]}#{y + 1} "
				end
			end
			print "#{y + 1} \n"
		end
		for i in 0..7
			print "  #{letters[i]}"
		end
		print "\n"
	end

	def object_at(position)
		x = position[0]
		y = position[1]
		object = @square[x][y]
		return object
	end

	def legal_move?(initial, target)
		initial = object_at(initial)
		target = object_at(target)
		return false if initial.class == Blank
		if initial.color != target.color
			return true if initial.class == Pawn or initial.class == Knight
			path = initial.path(target.position)
			path.pop
			path.each do |position|
				square = object_at(position)
				return false if square.class != Blank
			end	
			return true
		end
		return false
	end

	def move(initial, target)
		if object_at(initial).can_reach?(target) and legal_move?(initial, target)
			object_at(initial).position = target
			@square[target[0]][target[1]] = object_at(initial)
			@square[initial[0]][initial[1]] = Blank.new([initial[0], initial[1]])
			return true
		else
			return false
		end
	end
end