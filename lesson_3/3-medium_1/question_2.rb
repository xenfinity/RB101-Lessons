=begin
  The result of the following statement will be an error:

  Why is this and what are two possible ways to fix this?
  Because Ruby will try to add a string to an integer and an integer cannot be coerced into a string
  either use string interpolation or add .to_s to the end of the calculation
=end

puts "the value of 40 + 2 is " + (40 + 2).to_s