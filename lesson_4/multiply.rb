#Try coding a method that allows you to multiply every array item by a specified value

def multiply(numbers, operand)
  numbers.map { |num| num *= operand }
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3) # => [3, 12, 9, 21, 6, 18]
p my_numbers