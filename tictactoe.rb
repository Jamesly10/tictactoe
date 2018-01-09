#we're going to make checkers!
board = [
  ["_","_","_"],
  ["_","_","_"],
  ["_","_","_"]]


def draw_board(board)
  p ["_","0","1","2"]
  i = 0
  board.each do |b|
    p b.shift((i.to_s))
    i += 1
  end
end

# puts "What is your move?"
# move = gets.chomp.split(",")
# move = move.map {|e| e.to_i}
#
# p move
draw_board(board)
