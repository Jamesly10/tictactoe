def new_board
  #makes a new board
  [["X","X","X"],
  ["X","X","X"],
  ["X","X"," "]]
end

def check_move?(board,move)
  #checks to see if the move is valid or not, takes a board (3x3 array) and a two element array
  if board[move[0]][move[1]] == " "
    return true
  else
    return false
  end
end

def ai_move(board)
  p ai_move = [Random.rand(3),Random.rand(3)]
  until check_move?(board, ai_move)
    p ai_move = [Random.rand(3),Random.rand(3)]
  end
  p board
end

board = new_board
ai_move(board)
