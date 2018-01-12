def new_board
  #makes a new board
  [["_","_","_"],
  ["_","_","_"],
  ["_","_","_"]]
end

def draw_board(board)
  #draws the current board to the screen
  #maybe use a heredoc to draw the baord?

  #clears screen. I have no idea what this is doing. Need to look up.
  puts "\e[H\e[2J"

  #creates the number guides so people know how to play
  p spacer = ["_","0","1","2"]

  #places a guide on the left hand side
  i = 0
  board.each do |b|
    p b.unshift(i.to_s)
    i += 1
  end

  #takes the guide away before we return the board
  board.each do |b|
    b.shift()
    i += 1
  end

  #return the board
  board
end

def make_move(board,move,player)
  #takes a board and the move in a two element array, puts the move on the board
  #returns a board

  #check to see which player and set the marker
  player == 1 ? marker = "X" : marker = "O"

  #place the marker on the board
  board[move[0]][move[1]] = marker

  #draw the board to the screen
  draw_board(board)
end

def get_move
  #right now we expect the move to be two nums comma separated, needs work

  #prompt the user and get the move
  puts "What is your move?"
  move = gets.chomp.split(",")

  #turn the move into an array for later, return it
  move = move.map {|e| e.to_i}
end

def check_move?(board,move)
  #checks to see if the move is valid or not
  if board[move[0]][move[1]] == "_"
    return true
  else
    return false
  end
end

def check_win?(board,player)
  #check the player and set the marker for comparisons
  player == 1 ? marker = "X" : marker = "O"

  #set wins to false
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

#loop to run the game
while continue.downcase == 'y' do
  move_good = false
  draw_board(board)

  #swaps players and prompts them to play
  if player == 2
    player = 1
    puts "Player one, X, go!"
  elsif player == 1
    player = 2
    puts "Player two, O, go!"
  end

  #i think this is where I actually want to check for valid moves

  while move_good  == false do
    #p move_good
    move = get_move
    move_good = check_move?(board,move) #need to do something with this...
    puts "Invalid move, please try again!" if !move_good
    #pause = gets
  end

  #ok so I need to loop while the move is invalid
  make_move(board,move,player)


  if check_win?(board,player)
    puts "You won the game!\nPlay again? (y/n)"
    continue = gets.chomp.downcase
    board = new_board
    if continue != 'y'
      break
    end
  end
end
