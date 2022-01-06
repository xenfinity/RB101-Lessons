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

scores = {
  Player: 0,
  Dealer: 0
}

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
def hand_str(hand)
  hand_s = hand.map do |card|
    "#{VALUES[card % 13]} of #{SUITS[card / 13]}".capitalize
  end
  hand_s.join("\n")
end

# Displays the current state of the game
def display_cards(p_hand, d_hand, totals, eog=false)
  d_hand = eog ? hand_str(d_hand) : "#{hand_str([d_hand.first])}\nUnknown card"

  puts "Dealer has:\n#{d_hand}"
  puts LINE_BREAK
  puts "Value: #{totals[:Dealer]}"
  puts ""
  puts "You have:\n#{hand_str(p_hand)}"
  puts LINE_BREAK
  puts "Value: #{totals[:Player]}"
  puts ""
end

def sum_of_aces(score, aces)
  balance = CEILING - score
  sum_aces = aces.size * 11
  (aces.size).times do
    break if sum_aces <= balance
    sum_aces -= 10
  end
  sum_aces
end

# Returns the total value of the hand that's passed in
def hand_total(hand)
  hand = hand.map { |card| card % 13 }.sort
  aces, hand = hand.partition { |card| card == 12 }

  score = hand.reduce(0) do |sum, card|
    value = card % 13
    sum + (value < 9 ? value + 2 : 10)
  end

  ace_score = sum_of_aces(score, aces)
  score + ace_score
end

# Validates a 'hit' or 'stay' input from the player
def hit_or_stay?(input)
  %w(h s hit stay).include?(input)
end

def yes_or_no?(input)
  %w(y n yes no).include?(input)
end

# Prompts for, validates and returns player's choice
def player_choice
  input = nil
  loop do
    prompt("Would you like to hit or stay? (h/s)")
    input = gets.chomp.downcase
    hit_or_stay?(input) ? break : (puts "Invalid input")
  end
  input
end

# Creates a new deck in a random order
def initialize_deck
  deck = []
  0.upto(51) { |card| deck << card }
  deck.shuffle
end

def initialize_hand(deck, hand, dealer=false)
  2.times { deal_card(deck, hand) }
  dealer ? hand_total([hand.first]) : hand_total(hand)
end

# Deals a card from the deck into the hand passed in
def deal_card(deck, hand)
  hand << deck.shift
end

def player_turn(deck, player_hand, dealer_hand, totals, scores)
  until totals[:Player] > CEILING
    display(player_hand, dealer_hand, totals, scores)
    choice = player_choice

    choice.start_with?('h') ? deal_card(deck, player_hand) : break
    totals[:Player] = hand_total(player_hand)
  end
end

def dealer_turn(deck, dealer_hand)
  while hand_total(dealer_hand) <= CEILING - 4
    deal_card(deck, dealer_hand)
  end
end

# Determines the winner of the game
def winner?(totals)
  if totals[:Player] > CEILING
    DEALER_WIN
  elsif totals[:Dealer] > CEILING
    PLAYER_WIN
  elsif totals[:Dealer] > totals[:Player]
    DEALER_WIN
  elsif totals[:Player] > totals[:Dealer]
    PLAYER_WIN
  end
end

# Displays the winner and whether or not the loser busted
def display_winner(totals)
  if totals[:Player] > CEILING
    puts "You busted, dealer wins :("
  elsif totals[:Dealer] > CEILING
    puts "Dealer busted, you win!"
  elsif totals[:Dealer] > totals[:Player]
    puts "Dealer wins :("
  elsif totals[:Player] > totals[:Dealer]
    puts "You win!"
  else
    puts "Draw!"
  end
end

def update_score(winner, scores)
  winner == PLAYER_WIN ? scores[:Player] += 1 : scores[:Dealer] += 1
end

# Displays the running score
def display_score(scores)
  puts LINE_BREAK
  puts "Player: #{scores[:Player]}"
  puts "Dealer: #{scores[:Dealer]}"
  puts LINE_BREAK
end

def play_again?
  input = nil
  loop do
    prompt("Would you like to play again? (y/n)")
    input = gets.chomp
    break if yes_or_no?(input)
  end
  input.start_with?('y') ? true : false
end

def game_over(scores)
  if scores[:Player] > scores[:Dealer]
    prompt("Player wins the game! #{scores[:Player]}-#{scores[:Dealer]}")
  elsif scores[:Dealer] > scores[:Player]
    prompt("Dealer wins the game! #{scores[:Dealer]}-#{scores[:Player]}")
  else
    prompt("The game is a draw! #{scores[:Player]}-#{scores[:Dealer]}")
  end
end

def display(p_hand, d_hand, totals, scores, eog=false)
  system 'clear'
  display_cards(p_hand, d_hand, totals, eog)
  display_score(scores)
  display_winner(totals) if eog
end
# Display welcome message and determine game mode
prompt(WELCOME)
CEILING = game_mode

# Main game loop
loop do
  deck = initialize_deck
  player_hand = []
  dealer_hand = []

  player_total = initialize_hand(deck, player_hand)
  dealer_total = initialize_hand(deck, dealer_hand, true)
  totals = { Player: player_total, Dealer: dealer_total }

  player_turn(deck, player_hand, dealer_hand, totals, scores)
  dealer_turn(deck, dealer_hand, totals) if totals[:Player] <= CEILING
  totals[:Dealer] = hand_total(dealer_hand)

  winner = winner?(totals)
  update_score(winner, scores) if winner

  display(player_hand, dealer_hand, totals, scores, true)

  break if scores[:Player] >= 5 || scores[:Dealer] >= 5
  break unless play_again?
end

game_over(scores)
