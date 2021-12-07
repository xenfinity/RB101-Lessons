#Try coding a solution that doubles the numbers that have odd indices

def double_numbers(numbers)
  counter = 0
  doubled = []

  loop do
    break if counter == numbers.size
    if counter.odd?
      doubled << numbers[counter]*2 
    else
      doubled << numbers[counter]
    end
    
    counter += 1
  end
  doubled
end

my_numbers = [1, 4, 3, 7, 2, 6]
p double_numbers(my_numbers) # => [2, 8, 6, 14, 4, 12]
p my_numbers