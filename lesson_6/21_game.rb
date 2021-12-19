

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
    puts "Value: #{card_total(dealer)}"
  else
    puts "Dealer has:\n#{cards_to_s([dealer.first])}\nUnknown card"
    puts "Value: #{card_total([dealer.first])}"
  end

  puts ""
  puts "You have:\n#{cards_to_s(player)}"
  puts "Value: #{card_total(player)}"
  puts ""

end

def valid_input?(input)
  valid = input == 'h' || input == 's'
  unless valid
    puts "Invalid input, please enter 'h' or 's'"
  end
  valid
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

  score += sum_aces
  score
end

def initialize_deck
  deck = []
  0.upto(52) {|card| deck << card}
  deck.shuffle
end

def game_over(dealer, player, stay)
  if !stay
    puts "You busted, dealer wins :("
  elsif dealer > 21
    puts "Dealer busted, you win!"
  else
    dealer > player ? (puts "Dealer wins :(") : (puts "You win!")
  end
end

loop do
  deck = initialize_deck
  player_score = 0
  dealer_score = 0
  player_cards = []
  dealer_cards = []
  stay = false

  2.times { player_cards << deck.shift }
  2.times { dealer_cards << deck.shift }

  until stay || card_total(player_cards) > 21
    # Display initial cards dealt
    display_cards(dealer_cards, player_cards)
    # Player Turn
    prompt("Would you like to hit or stay? (h/s)")
    input = gets.chomp.downcase
    next unless valid_input?(input)

    input == 'h' ? (player_cards << deck.shift) : stay = true
  end

  until card_total(dealer_cards) > 17 && stay
    # Dealer Turn
    dealer_cards << deck.shift
  end

  d_value = card_total(dealer_cards)
  p_value = card_total(player_cards)
  display_cards(dealer_cards, player_cards, true)
  game_over(d_value, p_value, stay)

  prompt("Would you like to play again? (y/n)")
  input = gets.chomp
  break unless input.downcase == 'y'
end





