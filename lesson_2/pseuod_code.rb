=begin
  
1. a method that returns the sum of two integers

-Define a method that accepts two parameters
  -add the two integers together
  -return the result

START

SET add_method with two parameters (SET num1, SET num2)
  SET result = num1 + num2
  return result

END


2. a method that takes an array of strings, and returns a string that is all those strings concatenated together

-Define a method that accepts one parameter
  -define a variable 'result' and set it to an empty string
  -iterate over the array
  -concatenate each string to 'result' at each iteration
  -return the result

START

SET concat_method with one parameter (SET array)
  SET result = ""
  SET iterate = 1
  WHILE iterator <= length of array
   concatenate result and the string at the current location
   SET iterate += 1
  return result
EMD

3. a method that takes an array of integers, and returns a new array with every other element

-Define a method that accepts one parameter
  -define a variable 'result' and set it to an empty array
  -iterate over the array, incrementing the iterator by 2 instead of 1
  -on each iteration add the current value to the 'result' array
  -return 'result'

START

SET every_other_method with one parameter (SET array)
  SET result = []
  SET iterate = 1
  WHILE iterate <= array length
    push the value at the current location into 'result'
    SET iterate += 2
  return result

END

=end