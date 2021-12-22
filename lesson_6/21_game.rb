VALUES = ['two', 'three', 'four', 'five', 'six',
          'seven', 'eight', 'nine', 'ten', 'jack',
          'queen', 'king', 'ace']
SUITS = ['clubs', 'diamonds', 'hearts', 'spades']

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
  puts "------------------"
  puts "Value: #{d_total}"
  puts ""
  puts "You have:\n#{cards_to_s(player)}"
  puts "------------------"
  puts "Value: #{p_total}"
  puts ""
end

def valid_input?(input)
  input == 'h' || input == 's'
end

def card_total(cards)
  cards = cards.map { |card| card % 13 }.sort
  aces, cards = cards.partition { |card| card == 12 }

  score = cards.reduce(0) do |sum, card|
    value = card % 13
    sum += value < 9 ? value + 2 : 10
    sum
  end

  balance = 21 - score
  sum_aces = aces.size * 11
  (aces.size).times do
    break if sum_aces <= balance
    sum_aces -= 10
  end

  score + sum_aces
end

def initialize_deck
  deck = []
  0.upto(51) { |card| deck << card }
  deck.shuffle
end

def game_over(p_total, d_total)
  if p_total > 21
    puts "You busted, dealer wins :("
  elsif d_total > 21
    puts "Dealer busted, you win!"
  elsif d_total > p_total
    puts "Dealer wins :("
  elsif p_total > d_total
    puts "You win!"
  else
    puts "Draw!"
  end
end

def display_score()

end

player_score = 0
dealer_score = 0
input = nil

loop do
  deck = initialize_deck
  player_cards = []
  dealer_cards = []
  stay = false
  
  2.times { player_cards << deck.shift }
  2.times { dealer_cards << deck.shift }

  player_total = card_total(player_cards)
  dealer_total = card_total([dealer_cards.first])

  # Player turn
  until stay || player_total > 21
    display_cards(player_cards, dealer_cards, player_total, dealer_total)

    loop do
      prompt("Would you like to hit or stay? (h/s)")
      input = gets.chomp.downcase
      valid_input?(input) ? break : (puts "Invalid input")
    end

    input == 'h' ? player_cards << deck.shift : stay = true
    player_total = card_total(player_cards)
  end
  
  # Dealer turn
  while stay && card_total(dealer_cards) <= 17
    dealer_cards << deck.shift
  end

  dealer_total = card_total(dealer_cards)
  
  display_cards(player_cards, dealer_cards, player_total, dealer_total, true)
  game_over(player_total, dealer_total, player_score, dealer_score)

  p_score += 1 if player_total > dealer_total
  d_score += 1 if dealer_total > player_total
  display_score(p_score, d_score)

  prompt("Would you like to play again? (y/n)")
  input = gets.chomp
  break unless input.downcase.start_with?('y')
end
