VALUES = ['two', 'three', 'four', 'five', 'six',
          'seven', 'eight', 'nine', 'ten', 'jack',
          'queen', 'king', 'ace']
SUITS = ['clubs', 'diamonds', 'hearts', 'spades']
LINE_BREAK = "------------------"
PLAYER_WIN = "P"
DEALER_WIN = "D"
WELCOME = <<-PROMPT
Welcome to Whatever-One!

Please select a game mode:
1 - Twenty-One
2 - Thirty-One
3 - Forty-One
4 - Fifty-One
PROMPT

player_score = 0
dealer_score = 0
input = nil

# Printing method used to indent messages
def prompt(message)
  puts "=> #{message}"
end

# Returns game mode selected by the player
def game_mode
  input = nil
  loop do
    input = gets.chomp
    %w(1 2 3 4).include?(input) ? break : prompt("Invalid choice")
  end

  case input
  when '1' then 21
  when '2' then 31
  when '3' then 41
  else          51
  end
end

# Converts the cards in a hand to their string representation 
# returns the string
def hand_str(cards)
  cards_str = cards.map do |card|
    "#{VALUES[card % 13]} of #{SUITS[card / 13]}".capitalize
  end
  cards_str.join("\n")
end

# Displays the current state of the game 
def display_cards(player, dealer, p_total, d_total, eog=false)
  d_cards = eog ? hand_str(dealer) : "#{hand_str([dealer.first])}\nUnknown card"

  puts "Dealer has:\n#{d_cards}"
  puts LINE_BREAK
  puts "Value: #{d_total}"
  puts ""
  puts "You have:\n#{hand_str(player)}"
  puts LINE_BREAK
  puts "Value: #{p_total}"
  puts ""
end

# Returns the total value of the hand that's passed in
def hand_total(cards)
  cards = cards.map { |card| card % 13 }.sort
  aces, cards = cards.partition { |card| card == 12 }

  score = cards.reduce(0) do |sum, card|
    value = card % 13
    sum += value < 9 ? value + 2 : 10
  end

  balance = CEILING - score
  sum_aces = aces.size * 11
  (aces.size).times do
    break if sum_aces <= balance
    sum_aces -= 10
  end

  score + sum_aces
end

# Validates a 'hit' or 'stay' input from the player
def valid_input?(input)
  input == 'h' || input == 's'
end

# Prompts for, validates and returns player's choice
def player_choice
  input = nil
  loop do
    prompt("Would you like to hit or stay? (h/s)")
    input = gets.chomp.downcase
    valid_input?(input) ? break : (puts "Invalid input")
  end
  input
end

# Creates a new deck in a random order
def initialize_deck
  deck = []
  0.upto(51) { |card| deck << card }
  deck.shuffle
end

# Deals a card from the deck into the hand passed in
def deal_card(deck, hand)
  hand << deck.shift
end

# Determines the winner of the game
def winner?(p_total, d_total)
  if p_total > CEILING
    DEALER_WIN
  elsif d_total > CEILING
    PLAYER_WIN
  elsif d_total > p_total
    DEALER_WIN
  elsif p_total > d_total
    PLAYER_WIN
  end
end

# Displays the winner and whether or not the loser busted
def display_winner(p_total, d_total)
  if p_total > CEILING
    puts "You busted, dealer wins :("
  elsif d_total > CEILING
    puts "Dealer busted, you win!"
  elsif d_total > p_total
    puts "Dealer wins :("
  elsif p_total > d_total
    puts "You win!"
  else
    puts "Draw!"
  end
end

# Displays the running score 
def display_score(player_score, dealer_score)
  puts LINE_BREAK
  puts "Player: #{player_score}"
  puts "Dealer: #{dealer_score}"
  puts LINE_BREAK
end

# Display welcome message and determine game mode
prompt(WELCOME)
CEILING = game_mode

# Main game loop
loop do
  deck = initialize_deck
  player_cards = []
  dealer_cards = []
  stay = false

  2.times { deal_card(deck, player_cards) }
  2.times { deal_card(deck, dealer_cards) }

  player_total = hand_total(player_cards)
  dealer_total = hand_total([dealer_cards.first])

  # Player turn
  until stay || player_total > CEILING
    display_cards(player_cards, dealer_cards, player_total, dealer_total)
    choice = player_choice

    choice == 'h' ? deal_card(deck, player_cards) : stay = true
    player_total = hand_total(player_cards)
  end

  # Dealer turn
  while stay && hand_total(dealer_cards) <= CEILING - 4
    deal_card(deck, dealer_cards)
  end

  dealer_total = hand_total(dealer_cards)
  display_cards(player_cards, dealer_cards, player_total, dealer_total, true)

  winner = winner?(player_total, dealer_total)
  
  player_score += 1 if winner == PLAYER_WIN
  dealer_score += 1 if winner == DEALER_WIN

  display_winner(player_total, dealer_total)
  display_score(player_score, dealer_score)

  break if player_score >= 5 || dealer_score >= 5
  prompt("Would you like to play again? (y/n)")
  input = gets.chomp
  break unless input.downcase.start_with?('y')
end

# Display final score once game has ended
if player_score > dealer_score
  prompt("Player wins the game! #{player_score}-#{dealer_score}")
elsif dealer_score > player_score
  prompt("Dealer wins the game! #{dealer_score}-#{player_score}")
else
  prompt("The game is a draw! #{player_score}-#{dealer_score}")
end
