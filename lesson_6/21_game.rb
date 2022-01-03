VALUES = ['two', 'three', 'four', 'five', 'six',
          'seven', 'eight', 'nine', 'ten', 'jack',
          'queen', 'king', 'ace']
SUITS = ['clubs', 'diamonds', 'hearts', 'spades']
LINE_BREAK = "------------------"
PLAYER_WIN = "P"
DEALER_WIN = "D"

def game_mode
  message = <<-PROMPT
  Welcome to Whatever-One!

  Please select a game mode:
  1 - Twenty-One
  2 - Thirty-One
  3 - Forty-One
  4 - Fifty-One
  PROMPT
  prompt(message)

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

def prompt(message)
  puts "=> #{message}"
end

def cards_to_s(cards)
  cards_str = cards.map do |card|
    "#{VALUES[card % 13]} of #{SUITS[card / 13]}".capitalize
  end
  cards_str.join("\n")
end

def display_cards(player, dealer, p_total, d_total, eog=false)
  if eog
    d_cards = cards_to_s(dealer)
  else 
    d_cards = "#{cards_to_s([dealer.first])}\nUnknown card"
  end

  puts "Dealer has:\n#{d_cards}"
  puts LINE_BREAK
  puts "Value: #{d_total}"
  puts ""
  puts "You have:\n#{cards_to_s(player)}"
  puts LINE_BREAK
  puts "Value: #{p_total}"
  puts ""
end

def valid_input?(input)
  input == 'h' || input == 's'
end

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

def player_choice
  input = nil
  loop do
    prompt("Would you like to hit or stay? (h/s)")
    input = gets.chomp.downcase
    valid_input?(input) ? break : (puts "Invalid input")
  end
  input
end

def initialize_deck
  deck = []
  0.upto(51) { |card| deck << card }
  deck.shuffle
end

def deal_card(deck, hand)
  hand << deck.shift
end

def game_over(p_total, d_total)
  if p_total > CEILING
    puts "You busted, dealer wins :("
    DEALER_WIN 
  elsif d_total > CEILING
    puts "Dealer busted, you win!"
    PLAYER_WIN
  elsif d_total > p_total
    puts "Dealer wins :("
    DEALER_WIN 
  elsif p_total > d_total
    puts "You win!"
    PLAYER_WIN
  else
    puts "Draw!"
  end
end

def display_score(player_score, dealer_score)
  puts LINE_BREAK
  puts "Player: #{player_score}"
  puts "Dealer: #{dealer_score}"
end

player_score = 0
dealer_score = 0
input = nil
CEILING = game_mode

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
  winner = game_over(player_total, dealer_total)
  
  player_score += 1 if winner == PLAYER_WIN
  dealer_score += 1 if winner == DEALER_WIN 
    
  display_score(player_score, dealer_score)

  break if player_score >= 5 || dealer_score >= 5
  prompt("Would you like to play again? (y/n)")
  input = gets.chomp
  break unless input.downcase.start_with?('y')
end

if player_score > dealer_score
  prompt("Player wins the game! #{player_score}-#{dealer_score}") 
elsif dealer_score > player_score
  prompt("Dealer wins the game! #{dealer_score}-#{player_score}") 
else
  prompt("Draw! #{player_score}-#{dealer_score}")
end

