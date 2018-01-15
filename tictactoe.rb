class TicTacToe

  def initialize()
    puts "\e[H\e[2J"
    num_players = ""
    until num_players == 1 || num_players == 2 do
      puts "Welcome to Tic-Tac-Toe!\n1 player or 2 player?"
      num_players = gets.chomp.to_i # you can't use gets to set instance variables
    end
    #@continue = 'Y'
    @board = new_board
    @player = 2
    @marker = "O"
    @num_players = num_players
  end

  private

    def new_board
      #makes a new board
      [[" "," "," "],
      [" "," "," "],
      [" "," "," "]]
    end

    def draw_board()
      #draws the current board to the screen

      #clears screen. I have no idea what this is doing. Need to look up.
      puts "\e[H\e[2J"
      puts <<~EOB
         0   1   2

           |   |
      0  #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}
        ___|___|___
           |   |
      1  #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}
        ___|___|___
           |   |
      2  #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}
           |   |


      EOB

    end

    def swap_player()
      #swaps players and prompts them to play. Only asks player 2 if they are in the game
      if @player == 2
        @player = 1
        @marker = "X"
        puts "Player one, X, go!"
      elsif @player == 1
        @player = 2
        @marker = "O"
        if @num_players == 2
          puts "Player two, O, go!"
        end
      end
    end

    def make_move(move)
      #takes a board and the move in a two element array, puts the move on the board

      #place the marker on the board
      @board[move[0]][move[1]] = @marker
    end

    def ai_move()
      #takes a board and makes moves for the AI by picking random moves until one is valid
      ai_move = [Random.rand(3),Random.rand(3)]
      until check_move?(ai_move)
        ai_move = [Random.rand(3),Random.rand(3)]
      end
      ai_move
    end

    def get_move
      #right now we expect the move to be two nums comma separated, needs work
      # strings break this, need to put in a loop that only quits when we get a
      # two element array

      #prompt the user and get the move
      ####
      # I think I need to loop here until I get a move that is good. Maybe call check move here?
      ####
      move = nil
      until move do
        puts "What is your move?"
        move = gets.chomp.split(",")

        #turn the move into an array for later, return it
        move = move.map {|e| e.to_i}
      end
    end

    def check_move?(move)
      #checks to see if the move is valid or not, takes a board (3x3 array) and a two element array
      #this gets called by ai_move so don't change this!
      if @board[move[0]][move[1]] == " "
        true
      else
        false
      end
    end

    def check_stalemate?()
      #checks to see if we have played to a stalemate
      stalemate = true
      @board.each do |a|
        if a.include?(" ")
          stalemate = false
        end
      end
      stalemate
    end

    def check_win?()

      #set wins to false
      win = false

      #check the rows
      @board.each do |a|
        win = true if a[0] == @marker && a[1] == @marker && a[2] ==@marker
      end

      #check the columns, there has to be a better way to do this.
      win = true if @board[0][0] == @marker && @board[1][0] == @marker && @board[2][0] == @marker
      win = true if @board[0][1] == @marker && @board[1][1] == @marker && @board[2][1] == @marker
      win = true if @board[0][2] == @marker && @board[1][2] == @marker && @board[2][2] == @marker

      #check the two diag directions
      win = true if @board[0][0] == @marker && @board[1][1] == @marker && @board[2][2] == @marker
      win = true if @board[0][2] == @marker && @board[1][1] == @marker && @board[2][0] == @marker

      #return win
      win
    end

  public

    def run_game
      #initialize our local variable
      continue = 'Y'

      #loop to run the game
      while continue.downcase == 'y' do

        #draw out the board
        draw_board()

        #swap the players
        swap_player()

        #I set move good to false at the start of the turn so the loop works
        move_good = false

        #right now I loop here to see if moves are good.
        until move_good do # maybe move this entire loop to get_move?

          #if we are player 1 or if we are player 2 in a 2 player game
          move = if (@player == 1 || (@player == 2 && @num_players == 2))
            get_move

            #elsif we are player 2 in a 1 player game, we are the AI
          elsif (@player == 2 && @num_players == 1)
            ai_move
          end

          move_good = check_move?(move)
          puts "Invalid move, please try again!" unless move_good
        end

        #place the move on the board
        make_move(move)

        #check to see who has won the game and see if they want to play again. loop until they give a decent answer
        if check_win?()

          #draw out the board, its nice to see your victory
          draw_board()

          #reinitilize our variables for the next game
          @board = new_board
          @player = 2
          @num_players = 0

          #empty out continue so we don't skip past the prompts
          continue = ""

          #ask the player if they want to play again and grab the answer
          until continue == "y" || continue == "n" do
            puts "You won the game!\nPlay again? (y/n)"
            continue = gets.chomp.downcase
          end

          #if we don't want to continue, get out!
          break unless continue == 'y'

          #ask if we are playing a 1 player game or a 2 player game
          until @num_players == 1 || @num_players == 2 do
            puts "1 player or 2 player?"
            @num_players = gets.chomp.to_i
          end
        end
        if check_stalemate?()
          draw_board()

          #reinitilize our variables for the next game
          @board = new_board
          @player = 2
          @num_players = 0

          #empty out continue so we don't skip past the prompts
          continue = ""

          #ask the player if they want to play again and grab the answer
          until continue == "y" || continue == "n" do
            puts "You played to a stalemate!\nPlay again? (y/n)"
            continue = gets.chomp.downcase
          end

          #if we don't want to continue, get out!
          break unless continue == 'y'

          #ask if we are playing a 1 player game or a 2 player game
          until @num_players == 1 || @num_players == 2 do
            puts "1 player or 2 player?"
            @num_players = gets.chomp.to_i
          end
        end
      end
    end

end

TicTacToe.new.run_game
