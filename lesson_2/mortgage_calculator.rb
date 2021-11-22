require 'pry'
require 'yaml'

MESSAGES = YAML.load_file('mtg_calculator_msgs.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(input)
  input.to_i.to_s == input || input.to_f.to_s == input
end

prompt(MESSAGES['welcome'])
loan_amount, apr, years = nil
loop do
  loop do
    prompt(MESSAGES['loan_amount'])
    loan_amount = gets.chomp
    valid_number?(loan_amount) ? break : prompt(MESSAGES['invalid'])
  end

  loop do
    prompt(MESSAGES['APR'])
    apr = gets.chomp
    valid_number?(apr) ? break : prompt(MESSAGES['invalid'])
  end

  loop do
    prompt(MESSAGES['years'])
    years = gets.chomp
    valid_number?(years) ? break : prompt(MESSAGES['invalid'])
  end
  monthly_rate = (apr.to_f / 12) / 100
  monthly_payment = loan_amount.to_f *
                    (monthly_rate / 
                      (1 - (1 + monthly_rate)**(-years.to_i * 12))
                    )

  prompt("Monthly Payment:  $#{monthly_payment.round(2)}")

  prompt(MESSAGES['again?'])
  next if gets.chomp.downcase == 'y'
  break
end

prompt(MESSAGES['goodbye'])
