#fix play again

#store moves you've already done, and then have the computer do a move that is valid



def new_board
  #makes a new board
  [[" "," "," "],
  [" "," "," "],
  [" "," "," "]]

end

def draw_board(board_state)
  #draws the current board to the screen
  #maybe use a heredoc to draw the baord?

  #clears screen. I have no idea what this is doing. Need to look up.
  puts "\e[H\e[2J"
  <<~EOB
     0   1   2

       |   |
  0  #{board_state[0][0]} | #{board_state[0][1]} | #{board_state[0][2]}
    ___|___|___
       |   |
  1  #{board_state[1][0]} | #{board_state[1][1]} | #{board_state[1][2]}
    ___|___|___
       |   |
  2  #{board_state[2][0]} | #{board_state[2][1]} | #{board_state[2][2]}
       |   |


  EOB
  #creates the number guides so people know how to play
  # p spacer = ["_","0","1","2"]
  #
  # #places a guide on the left hand side
  # i = 0
  # board_state.each do |b|
  #   p b.unshift(i.to_s)
  #   i += 1
  # end
  #
  # #takes the guide away before we return the board
  # board_state.each do |b|
  #   b.shift()
  #   i += 1
  # end

  #return the board
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

def ai_move(board)
  ai_move = [Random.rand(3),Random.rand(3)]
  until check_move?(board, ai_move)
    ai_move = [Random.rand(3),Random.rand(3)]
  end
  ai_move
end

def get_move
  #right now we expect the move to be two nums comma separated, needs work
  # strings break this, need to put in a loop that only quits when we get a
  # two element array

  #prompt the user and get the move
  puts "What is your move?"
  move = gets.chomp.split(",")

  #turn the move into an array for later, return it
  move = move.map {|e| e.to_i}
end

def check_move?(board,move)
  #checks to see if the move is valid or not, takes a board (3x3 array) and a two element array
  if board[move[0]][move[1]] == " "
    return true
  else
    return false
  end
end

def check_stalemate?(board,player)
  stalemate = true
  board.each do |a|
    if a.include?(" ")
      stalemate = false
    end
  end
  stalemate
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

#how do I implement the AI in the game? I need to ask the player if they want to do one player or two player
#loop to run the game

puts "1 player or 2 player?"
ai_player = gets.chomp.to_i

while continue.downcase == 'y' do
  move_good = false
  puts  draw_board(board)

  #swaps players and prompts them to play
  if player == 2
    player = 1
    puts "Player one, X, go!"
  elsif player == 1
    player = 2
    if ai_player == 2
      puts "Player two, O, go!"
    end
  end

  #i think this is where I actually want to check for valid moves

  while move_good  == false do
    #p move_good
    p "in move_good"
    move = if player == 1 || (player == 2 && ai_player == 2)
      get_move
    elsif (player == 2 && ai_player == 1)
      "one player"
      ai_move(board)
    end
    move_good = check_move?(board,move) #need to do something with this...
    puts "Invalid move, please try again!" if !move_good
    #pause = gets
  end

  #place the move on the board
  make_move(board,move,player)

  #check to see who has won the game and see if they want to play again
  if check_win?(board,player)
    draw_board(board)
    puts "You won the game!\nPlay again? (y/n)"
    continue = gets.chomp.downcase
    board = new_board
    if continue != 'y'
      break
    end
  end
  if check_stalemate?(board,player)
    draw_board(board)
    puts "You played to a stalemate!\nPlay again? (y/n)"
    continue = gets.chomp.downcase
    board = new_board
    if continue != 'y'
      break
    end
  end
end
