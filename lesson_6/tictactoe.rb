EMPTY = ' '
PLAYER = 'X'
COMP = 'O'

WIN_STATES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
              [1, 4, 7], [2, 5, 8], [3, 6, 9],
              [1, 5, 9], [7, 5, 3]]

def prompt(message)
  puts "=> #{message}"
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

def winner?(board)
  winner = nil

  WIN_STATES.each do |win|
    state = [board[win[0]], board[win[1]], board[win[2]]]
    winner = PLAYER if state.all?(PLAYER)
    winner = COMP if state.all?(COMP)
    break if winner
  end
  
  winner = 'D' unless winner || board.values.any?(EMPTY)
  winner
end

def initialize_board
  board = Hash.new
  1.upto(9) { |i| board[i] = EMPTY }
  board
end

def valid_choice?(input, choices)
  if input != input.to_i.to_s
    puts "Invalid input, please enter an integer"
    false
  elsif !choices.include?(input.to_i)
    puts "Invalid input, choice must be from available spaces"
    false
  else
    true
  end
end

def find_choices(board)
  board.keys.select { |key| board[key] == ' ' }
end

def player_turn!(board)
  choices = find_choices(board)

  loop do
    prompt "Choose a square (#{choices.join(', ')}): "
    input = gets.chomp

    valid_choice?(input, choices) ? board[input.to_i] = PLAYER : next
    break
  end
end

def comp_turn!(board)
  choices = find_choices(board)

  
end



# board = array of 3x3
board = {
  1 => 'O',
  2 => ' ',
  3 => 'O',
  4 => 'O',
  5 => ' ',
  6 => ' ',
  7 => 'X',
  8 => ' ',
  9 => 'X',
}


player_turn!(board)
display_board(board)
p winner?(board)
