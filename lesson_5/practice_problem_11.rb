# Given the following data structure use a combination of methods, including either the select or reject method, to return a new array 
# identical in structure to the original but containing only the integers that are multiples of 3.

arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

=begin
  iterate over arr with map
    iterate over each subarray with select
      within select block return true only if the number % 3 == 0
=end

multiples_of_3 = arr.map do |subarray|
  subarray.select{|num| num % 3 == 0}
end

p multiples_of_3