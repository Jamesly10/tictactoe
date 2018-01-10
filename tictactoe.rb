#we're going to make tictactoe!

#to-do - prevent illegal moves
# =>     sanitaize data inputs

def new_board
  #makes a new board
   [["_","_","_"],
    ["_","_","_"],
    ["_","_","_"]]
end

def draw_board(board)
  #draws the current board to the screen
  puts "\e[H\e[2J"  #clears screen. I have no idea what this is doing. Need to look up.

  #creates the number guides so people know how to play
  p spacer = ["_","0","1","2"]

  #places a guide on the left hand side
  i = 0
  board.each do |b|
    p b.unshift(i.to_s)
    i += 1
  end
#
  #takes the guide away before we return the state of the board
  board.each do |b|
    b.shift()
    i += 1
  end

  board
end

def make_move(board,move,player)
  #takes a board and the move in a two element array, puts the move on the board
  player == 1 ? marker = "X" : marker = "O"
  board[move[0]][move[1]] = marker
  draw_board(board)
end

def get_move
  #right now we expect the move to be two nums comma separated, needs work
  puts "What is your move?"
  move = gets.chomp.split(",")
  move = move.map {|e| e.to_i}
end

def check_win?(board,player)
  player == 1 ? marker = "X" : marker = "O"
  #checks to see if anyone has won the game
  win = false
  #check the rows
  board.each do |a|
    win = true if a[0] == marker && a[1] == marker && a[2] ==marker
  end
  #check the columns, there has to be a better way to do this.
  win = true if board[0][0] == marker && board[1][0] == marker && board[2][0] == marker
  win = true if board[0][1] == marker && board[1][1] == marker && board[2][1] == marker
  win = true if board[0][2] == marker && board[1][2] == marker && board[2][2] == marker
  #check the two diag directions
  win = true if board[0][0] == marker && board[1][1] == marker && board[2][2] == marker
  win = true if board[0][2] == marker && board[1][1] == marker && board[2][0] == marker

  #return win
  win
end

#initialize our variables
continue = 'Y'
board = new_board
player = 2


while continue.downcase == 'y' do
  draw_board(board)

  if player == 2
    p player = 1
  elsif player == 1
    p player = 2
  end

  move = get_move
  make_move(board,move,player)
  if check_win?(board,player)
    puts "You won the game!"
    puts "Play again? (y/n)"
    continue = gets.chomp.downcase
    board = new_board
    if continue != 'y'
      break
    end
  end
end
