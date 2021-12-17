EMPTY = ' '
FIRST = 'X'
SECOND = 'O'
CORNERS = [1, 3, 7, 9]
CENTER = 5
WIN_STATES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
              [1, 4, 7], [2, 5, 8], [3, 6, 9],
              [1, 5, 9], [7, 5, 3]]

def prompt(message)
  puts "=> #{message}"
end

def joinor(choices, delim=', ', tail='or')
  choices[0...-1].join(delim) +
    ' ' + tail + ' ' +
    choices[-1].to_s
end

def display_board(board)
  puts ""
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "_____|_____|_____"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "_____|_____|_____"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board(map=false)
  board = Hash.new
  1.upto(9) do |i|
    board[i] = map ? i : EMPTY     
  end
  board
end

def valid_choice?(input, choices)
  unless input == input.to_i.to_s && choices.include?(input.to_i)
    prompt("Invalid input, please enter an integer from the available choices")
    return false
  end
  true
end

def find_choices(board)
  board.keys.select { |key| board[key] == ' ' }
end

def winner?(board)
  winner = nil

  WIN_STATES.each do |win|
    state = [board[win[0]], board[win[1]], board[win[2]]]
    winner = FIRST if state.all?(FIRST)
    winner = SECOND if state.all?(SECOND)
    break if winner
  end

  winner = 'D' unless winner || board.values.any?(EMPTY)
  winner
end

def player_turn(board)
  choices = find_choices(board)

  loop do
    prompt("Choose a square (#{joinor(choices)}): ")
    input = gets.chomp

    return input.to_i if valid_choice?(input, choices)
  end
end

def comp_turn(board, opp, comp, easy)
  choices = find_choices(board)
  return choices.sample if easy

  opp_squares = board.keys.select { |sq| board[sq] == opp }
  comp_squares = board.keys.select { |sq| board[sq] == comp }

  # splits the win states into two categories, lines that cannot lead to victory
  # and lines that can lead to victory - reversed since winning is prioritized
  # for next iteration
  partitioned = WIN_STATES.partition do |state|
    state.any? { |sq| opp_squares.include?(sq) }
  end.reverse
  win_lines = partitioned.first

  # if computer goes first, choose square #1
  return 1 if choices.size == 9

  # if computer goes second, choose square #5 if it's available
  return CENTER if choices.size == 8 && choices.include?(CENTER)
 
  # Is there an available win line that has two O's? If so, take it for victory
  # Is there an unavailable win line that has two X's? If so, block it to
  # prevent opponent victory
  partitioned.each do |partition|
    partition.each do |line|
      state = line.map { |sq| board[sq] }

      next unless state.any?(EMPTY)
      if state.count(opp) == 2 || state.count(comp) == 2
        return line[state.index(EMPTY)]
      end
    end
  end

  # Calculates a weight for each available square based on the following
  # criteria:
  # square is in a corner and also included in a win line that:
  #   already has a comp piece in it
  #   runs along the edge of the board
  weights = choices.map do |sq|
    weight = 0
    win_lines.each do |line|
      next unless line.include?(sq)
      comp_squares.each do |cmp_sq|
        weight += 1 if line.include?(cmp_sq) &&
                       !line.include?(CENTER) &&
                       CORNERS.include?(sq)
      end
    end
    weight
  end

  max_index = weights.index(weights.max)
  choices[max_index]
end

def display_score(p_score, c_score)
  p_score = p_score.to_s.rjust(2, '0')
  c_score = c_score.to_s.rjust(2, '0')
  puts <<-MSG
  ______________________
  |  PLAYER  | COMPUTER |
  |    #{p_score}    |    #{c_score}    |
  |__________|__________|
  MSG
end

game = 1
player_score = 0
computer_score = 0

map = initialize_board(true)
puts "WELCOME TO TIC TAC TOE!"
display_board(map)

# Main game loop
loop do
  easy = nil

  # Select game mode - Easy or Hard
  until !easy.nil?
    prompt("Easy mode (e) or hard mode (h)? ")
    input = gets.chomp.downcase

    case input
    when 'e' then easy = true
    when 'h' then easy = false
    else prompt("Invalid input, please choose 'e' or 'h'")
    end
  end

  # Initialize empty board and determine turn order
  board = initialize_board
  order = [FIRST, SECOND]
  player = game.odd? ? FIRST : SECOND
  computer = game.even? ? FIRST : SECOND
  player == FIRST ? (prompt("You are X's!")) : (prompt("You are O's!"))

  # Round loop
  loop do
    if player == order.first
      board[player_turn(board)] = player
    else
      board[comp_turn(board, player, computer, easy)] = computer
      display_board(board)
    end
    break if winner?(board)
    order.rotate!
  end

  display_board(board) if player == order.first

  # Determine winner
  case winner?(board)
  when player
    prompt("Player wins!")
    player_score += 1
  when computer
    prompt("Computer wins!")
    computer_score += 1
  else
    prompt("Draw!")
  end

  game += 1
  display_score(player_score, computer_score)

  prompt("Would you like to play again? (y/n)")
  input = gets.chomp
  break unless input.downcase == 'y'
end

prompt("Thanks for playing Tic Tac Toe!")
