class Board
	attr_accessor :board

	def initialize(size)
		@board = []
		for i in 0..size - 1
			temp = []
			for j in 0..size - 1
				temp[j] = false
			end
			@board[i] = temp
		end
	end

	def two_random
		[[rand(board.size), rand(board.size)], [rand(board.size), rand(board.size)]]
	end

	def valid_field?(field)
		!(field[0] < 0 || field[0] >= board.size || field[1] < 0 || field[1] >= board.size)
	end
end

class Knight

	def valid(board, field)
		return [] unless board.valid_field?(field)
		valid_moves = [[field[0] + 2, field[1] + 1],
									 [field[0] + 2, field[1] - 1],
									 [field[0] + 1, field[1] + 2],
									 [field[0] + 1, field[1] - 2],
									 [field[0] - 1, field[1] + 2],
									 [field[0] - 1, field[1] - 2],
									 [field[0] - 2, field[1] + 1],
									 [field[0] - 2, field[1] - 1]]
		valid_moves.select! { |move|
			board.valid_field?(move) && !board.board[move[0]][move[1]]
		}
		valid_moves
	end

	def knight_moves_helper(start, finish, board)
		queue = [[start]]
		while queue.size > 0
			moves = valid(board, queue.first.last)
			if moves.include?(finish)
				queue.first.push(finish)
				return queue.first
			else
				moves.each do |move|
					add_to_queue = queue.first.dup
					add_to_queue.push(move)
					queue.push(add_to_queue)				
				end
			end
			queue.delete_at(0)
		end
	end

	def knight_moves(start, finish)
		board = Board.new(8)
		unless board.valid_field?(start) && board.valid_field?(finish)
			puts "Start or Finish field falls outside the board."
			return
		end
		track = knight_moves_helper(start, finish, board)
		puts "You made it in #{track.size} moves! Here's your path:"
		track.each do |move|
			puts move.to_s
		end
	end
end

Knight.new.knight_moves([0, 7], [7, 0])