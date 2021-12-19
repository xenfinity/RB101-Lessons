

VALUES = ['two','three','four','five','six',
          'seven','eight','nine','ten','jack',
          'queen','king','ace']
SUITS = ['clubs','diamonds','hearts','spades']

def prompt(message)
  puts "=> #{message}"
end

def cards_to_s(cards)
  cards_str = cards.map do |card| 
    "#{VALUES[card%13]} of #{SUITS[card/13]}".capitalize
  end
  cards_str.join("\n")
end

def display_cards(dealer, player, eog=false)
  if eog
    puts "Dealer has:\n#{cards_to_s(dealer)}"
    puts "-----------------------------"
    puts "Value: #{card_total(dealer)}"
  else
    puts "Dealer has:\n#{cards_to_s([dealer.first])}\nUnknown card"
    puts "------------------"
    puts "Value: #{card_total([dealer.first])}"
  end

  puts ""
  puts "You have:\n#{cards_to_s(player)}"
  puts "------------------"
  puts "Value: #{card_total(player)}"
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
  0.upto(51) {|card| deck << card}
  deck.shuffle
end

def game_over(dealer, player)
  if player > 21
    puts "You busted, dealer wins :("
  elsif dealer > 21
    puts "Dealer busted, you win!"
  else
    if dealer > player
      puts "Dealer wins :("
    elsif player > dealer
      puts "You win!"
    else
      puts "Draw!"
    end
  end
end

loop do
  deck = initialize_deck
  player_cards = []
  dealer_cards = []
  stay = false
  input = nil

  2.times { player_cards << deck.shift }
  2.times { dealer_cards << deck.shift }

  # Player turn
  until stay || card_total(player_cards) > 21
    display_cards(dealer_cards, player_cards)

    loop do
      prompt("Would you like to hit or stay? (h/s)")
      input = gets.chomp.downcase
      valid_input?(input) ? break : (puts "Invalid input")
    end

    input == 'h' ? player_cards << deck.shift : stay = true
  end

  # Dealer turn
  while stay && card_total(dealer_cards) <= 17
    dealer_cards << deck.shift
  end

  d_value = card_total(dealer_cards)
  p_value = card_total(player_cards)
  display_cards(dealer_cards, player_cards, true)
  game_over(d_value, p_value)

  prompt("Would you like to play again? (y/n)")
  input = gets.chomp
  break unless input.downcase.start_with?('y')
end





