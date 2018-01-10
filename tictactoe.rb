#we're going to make checkers!
def draw_board(board)
  puts "\e[H\e[2J"  #I have no idea what this is doing. Need to look up.
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
  draw_board(board)
end

def get_move
  puts "What is your move?"
  move = gets.chomp.split(",")
  move = move.map {|e| e.to_i}
end

def check_win(board)
  win = false
  board.each do |a|
    if a[0] == 'X' && a[1] == 'X' && a[2] =='X'
      win = true
    end
  end
  win
end


continue = 'Y'
board = [
  ["_","_","_"],
  ["_","_","_"],
  ["_","_","_"]]

while continue.downcase == 'y' do
  draw_board(board)
  move = get_move
  make_move(board,move)
  if check_win(board)
    puts "You won the game!"
    puts "Play again? (y/n)"
    continue = gets.chomp.downcase
    if continue != 'y'
      break
    end
  end
end
