#we're going to make checkers!
board = [
  ["_","_","_"],
  ["_","_","_"],
  ["_","_","_"]]


def draw_board(board)
  p spacer = ["_","0","1","2"]
  i = 0
  board.each do |b|
    p b.unshift(i.to_s)
    i += 1
  end
  board.each do |b|
    b.shift()
    i += 1
  end
  board
end

def make_move(board,move)
  move_x=move[0]
  move_y=move[1]
  board[move_x][move_y] = "X"
  board.each do |b|
    p b
  end
end

def get_move
  puts "What is your move?"
  move = gets.chomp.split(",")
  move = move.map {|e| e.to_i}
end
#

draw_board(board)
move = get_move
make_move(board,move)
