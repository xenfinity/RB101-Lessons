=begin
  The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ:
  numbers = [1, 2, 3, 4, 5]
  
  What do the following method calls do (assume we reset numbers to the original array between method calls)?
  numbers.delete_at(1)
    removes the element in numbers located at index 1 (2) - returns 2, numbers = [1,3,4,5]

  numbers.delete(1)
    removes all elements in numbers that equal 1 - returns 1, numbers = [2,3,4,5]
=end

numbers = [1, 2, 3, 4, 5]
p numbers.delete_at(1)
p numbers
numbers = [1, 2, 3, 4, 5]
p numbers.delete(1)
p numbers