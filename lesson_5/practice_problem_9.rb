# Given this data structure, return a new array of the same structure but with the sub arrays 
# being ordered (alphabetically or numerically as appropriate) in descending order.

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.each do |subarray|
  subarray.sort!{|a, b| b <=> a}
end
p arr

# ! not necessary on sort call if you use map instead of each
# map is a better choice for this probelm because you're transforming the array

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

sorted = arr.map do |subarray|
  subarray.sort do |a, b|
    b <=> a
  end
end

p sorted
