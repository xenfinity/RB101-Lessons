require "pry"
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i.to_s == num || num.to_f.to_s == num
end 

def operation_to_message(op)
  message = case op
            when '1' then 'Adding'
            when '2' then 'Subtracting'
            when '3' then 'Multiplying'
            when '4' then 'Dividing'
            end
  #optional code here
  message
end



prompt(MESSAGES['welcome'])
name =''
loop do
  name = Kernel.gets().chomp()
  name.empty?() ? prompt(MESSAGES['valid_name']) : break
end

prompt("Hi #{name}!")
loop do
  num1 = ''
  num2 = ''
  loop do
    prompt(MESSAGES['first'])
    num1 = Kernel.gets().chomp()
    valid_number?(num1) ? break : prompt(MESSAGES['invalid'])  
  end

  loop do
    prompt(MESSAGES['second'])
    num2 = Kernel.gets().chomp()
    valid_number?(num2) ? break : prompt(MESSAGES['invalid'])  
  end
  op = ''
  prompt(MESSAGES['operator_prompt'])

  loop do 
    op = Kernel.gets().chomp()
    %w(1 2 3 4).include?(op) ? break : prompt(MESSAGES['invalid_op'])
  end
  prompt("#{operation_to_message(op)} the two numbers...")
  result = case op
           when '1' then num1.to_f() + num2.to_f()
           when '2' then num1.to_f() - num2.to_f()
           when '3' then num1.to_f() * num2.to_f()
           else num1.to_f() / num2.to_f() unless num2.to_f.zero?
           end

  prompt("The result is #{result}")
  prompt(MESSAGES['again?'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(MESSAGES['goodbye'])