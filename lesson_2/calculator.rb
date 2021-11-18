def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i.to_s == num
end 

def operation_to_message(op)
  case op
  when '1' then 'Adding'
  when '2' then 'Subtracting'
  when '3' then 'Multiplying'
  when '4' then 'Dividing'
  end
end



prompt("Welcome to Calculator! Enter your name: ")
name =''
loop do
  name = Kernel.gets().chomp()
  name.empty?() ? prompt("Please use a valid name") : break
end

prompt("Hi #{name}!")
loop do
  num1 = ''
  num2 = ''
  loop do
    prompt("Please enter the first operand: ")
    num1 = Kernel.gets().chomp()
    valid_number?(num1) ? break : prompt("Invalid number")  
  end

  loop do
    prompt("Please enter the second operand: ")
    num2 = Kernel.gets().chomp()
    valid_number?(num2) ? break : prompt("Invalid number")  
  end
  
  op = ''
  operator_prompt = <<-MSG
    What operation would you like to perform? 
    1) add 
    2) subtract 
    3) multiply 
    4) divide
  MSG
  prompt(operator_prompt)

  loop do 
    op = Kernel.gets().chomp()
    %w(1 2 3 4).include?(op) ? break : prompt("Must choose 1, 2, 3 or 4")
  end
  prompt("#{operation_to_message(op)} the two numbers...")
  result = case op
  when '1' then num1.to_i() + num2.to_i()
  when '2' then num1.to_i() - num2.to_i()
  when '3' then num1.to_i() * num2.to_i()
  else num1.to_f() / num2.to_f() unless num2.to_f.zero?
  end

  prompt("The result is #{result}")
  prompt("Do you want to perform another calculation? (Y to caculate again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using the calculator. Goodbye!")