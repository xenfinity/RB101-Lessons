#If we wanted to, we could've easily decided that mutating the method argument is the right approach. Can you implement a double_numbers! method that mutates its argument?

def double_numbers(numbers)
  counter = 0

  loop do
    break if counter == numbers.size

    numbers[counter] *= 2

    counter += 1
  end
  numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
p double_numbers(my_numbers) # => [2, 8, 6, 14, 4, 12]
p my_numbers