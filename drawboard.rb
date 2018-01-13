def new_board
  #makes a new board
  [[" "," "," "],
  [" "," "," "],
  [" "," "," "]]
end

def draw_board(board_state)
  <<~EOB
  #{board_state[0][0]} | #{board_state[0][1]} | #{board_state[0][2]}
  ----------
  #{board_state[1][0]} | #{board_state[1][1]} | #{board_state[1][2]}
  ----------
  #{board_state[2][0]} | #{board_state[2][1]} | #{board_state[2][2]}
  EOB
end

board_state = new_board
puts draw_board(board_state)
