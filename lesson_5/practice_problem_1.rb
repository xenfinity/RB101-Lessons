#How would you order this array of number strings by descending numeric value?

arr = ['10', '11', '9', '7', '8']

sorted = arr.sort_by do |e|
  e.to_i
end.reverse

p sorted