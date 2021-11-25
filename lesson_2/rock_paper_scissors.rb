require 'yaml'

MESSAGES = YAML.load_file('rps_messages.yml')
CHOICES = {
  '1' => "Rock",
  '2' => "Paper",
  '3' => "Scissors"
}

PLAYER_WINS = {
  ['1', '2'] => false,
  ['1', '3'] => true,
  ['2', '1'] => true,
  ['3', '1'] => false,
  ['2', '3'] => false,
  ['3', '2'] => true
}

def prompt(message)
  puts "=> #{message}"
end

def display_winner(player, computer)
  prompt("You chose: #{CHOICES[player]}, Computer chose: #{CHOICES[computer]}")

  if player == computer
    prompt(MESSAGES['draw'])
  elsif PLAYER_WINS[[player, computer]]
    prompt(MESSAGES['player_win'])
  else
    prompt(MESSAGES['comp_win'])
  end
end

def display_scoreboard(player, computer)
  puts <<-MSG
    SCOREBOARD
    ----------------
    Player: #{player}
    Computer: #{computer}
  MSG
end

player_score = 0
comp_score = 0
choice = nil

prompt(MESSAGES['welcome'])

loop do
  # Get player choice
  while choice != 'q'
    prompt(MESSAGES['choice'])
    choice = gets.chomp
    %w(1 2 3 q).include?(choice) ? break : prompt(MESSAGES['invalid'])
  end

  # Exit loop if player wants to quit
  break if choice == 'q'

  # Calculate computer choice
  comp_choice = %w(1 2 3).sample

  # Display the winner
  display_winner(choice, comp_choice)

  # Increment winner's score if it wasn't a draw
  if choice != comp_choice
    PLAYER_WINS[[choice, comp_choice]] ? player_score += 1 : comp_score += 1
  end

  # Display running scoreboard
  display_scoreboard(player_score, comp_score)
end

prompt(MESSAGES['goodbye'])
