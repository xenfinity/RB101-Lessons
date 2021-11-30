=begin
Alan wrote the following method, which was intended to show all of the factors of the input number:

Alyssa noticed that this will fail if the input is 0, or a negative number, and asked Alan to change the loop. 
How can you make this work without using begin/end/until? Note that we're not looking to find the factors for 0 
or negative numbers, but we just want to handle it gracefully instead of raising an exception or going into an infinite loop.

Bonus 1
What is the purpose of the number % divisor == 0 ?
makes sure that when the number is divided by the divisor that there are no remainders, meaning that it divides evenly 


Bonus 2
What is the purpose of the second-to-last line (line 8) in the method (the factors before the method's end)?
this is an implicit return value which I changed in my solution
=end

def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end 
  return factors unless number <= 0
  "Number is not a positive integer"
end

p factors(48)