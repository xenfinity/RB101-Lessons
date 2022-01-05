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
  board_hd = <<-MSG
  
       |     |
    #{board[1]}  |  #{board[2]}  |  #{board[3]}
  _____|_____|_____
       |     |
    #{board[4]}  |  #{board[5]}  |  #{board[6]}
  _____|_____|_____
       |     |
    #{board[7]}  |  #{board[8]}  |  #{board[9]}
       |     |
  
  MSG
  puts board_hd
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

def comp_goes_first?(choices)
  choices.size == 9
end

def second_and_center?(choices)
  choices.size == 8 && choices.include?(CENTER)
end

def critical_square?(board, lines, mark)
  lines.each do |line|
    state = line.map { |sq| board[sq] }
    next unless state.any?(EMPTY)
    return line[state.index(EMPTY)] if state.count(mark) == 2
  end
  nil
end

def split_win_states(board, opp)
  opp_squares = board.keys.select { |sq| board[sq] == opp }
  WIN_STATES.partition do |state|
    state.any? { |sq| opp_squares.include?(sq) }
  end.reverse
end

def desireable_square?(line, cmp_sq, sq)
  line.include?(cmp_sq) &&
    !line.include?(CENTER) &&
    CORNERS.include?(sq)
end

def state(board, opp, comp)
  choices = find_choices(board)
  lines = split_win_states(board, opp)
  win_line = critical_square?(board, lines.first, comp)
  block_line = critical_square?(board, lines.last, opp)

  [choices, lines, win_line, block_line]
end

def find_weights(choices, win_lines, comp_squares)
  choices.map do |sq|
    weight = 0
    win_lines.each do |line|
      next unless line.include?(sq)
      comp_squares.each do |cmp_sq|
        weight += 1 if desireable_square?(line, cmp_sq, sq)
      end
    end
    weight
  end
end

def weighted_line(board, comp, choices, win_lines)
  comp_squares = board.keys.select { |sq| board[sq] == comp }
  weights = find_weights(choices, win_lines, comp_squares)

  max_index = weights.index(weights.max)
  choices[max_index]
end

def comp_turn(board, opp, comp, easy)
  choices, lines, win_line, block_line = state(board, opp, comp)

  if easy
    choices.sample
  elsif comp_goes_first?(choices)
    1
  elsif second_and_center?(choices)
    CENTER
  elsif win_line
    win_line
  elsif block_line
    block_line
  else
    weighted_line(board, comp, choices, lines.first)
  end
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

def yes_or_no?(input)
  %w(y n yes no).include?(input.downcase)
end

def easy_or_hard?(input)
  %w(e h easy hard).include?(input.downcase)
end

def display(mark, map, board, score)
  system 'clear'
  prompt(mark)
  display_board(map)
  display_board(board)
  display_score(score.first, score.last)
end

def game_mode
  input = nil
  loop do
    prompt("Easy mode (e) or hard mode (h)? ")
    input = gets.chomp.downcase

    break if easy_or_hard?(input)
    prompt("Invalid input, please enter 'e' or 'h'")
  end
  input.start_with?('e') ? true : false
end

def determine_turn_order(game)
  order = [FIRST, SECOND]
  player = game.odd? ? FIRST : SECOND
  computer = game.even? ? FIRST : SECOND
  mark = player == FIRST ? "You are X's!" : "You are O's!"

  [order, player, computer, mark]
end

def play_turn(board, order, player, computer, easy)
  if player == order.first
    board[player_turn(board)] = player
  else
    board[comp_turn(board, player, computer, easy)] = computer
  end
end

def update_score(winner, player, computer, score)
  case winner
  when player
    score[0] += 1
  when computer
    score[1] += 1
  end
  score
end

def display_winner(winner, player, computer)
  case winner
  when player
    prompt("Player wins!")
  when computer
    prompt("Computer wins!")
  else
    prompt("Draw!")
  end
end

def play_again?
  input = nil
  loop do
    prompt("Would you like to play again? (y/n)")
    input = gets.chomp
    break if yes_or_no?(input)
    prompt("Invalid input, please enter 'y' or 'n'")
  end
  input.start_with?('y') ? true : false
end

game = 1
score = [0, 0]

map = initialize_board(true)
puts "WELCOME TO TIC TAC TOE!"
display_board(map)

# Main game loop
loop do
  easy = game_mode
  board = initialize_board
  order, player, computer, mark = determine_turn_order(game)

  # Round loop
  loop do
    display(mark, map, board, score)
    play_turn(board, order, player, computer, easy)
    break if winner?(board)
    order.rotate!
  end

  winner = winner?(board)
  update_score(winner, player, computer, score)
  display(mark, map, board, score)
  display_winner(winner, player, computer)

  game += 1
  break unless play_again?
end

prompt("Thanks for playing Tic Tac Toe!")
