# PROBLEM:

# Given a string, write a method change_me which returns the same
# string but with all the words in it that are palindromes uppercased.
=begin
  Problem - empty string returns empty string
            non palindromes are case-sensitive
            palindromes are case-sensitive (Mom is not a palindrome)
            return a new string

  Algorithm - split string by spaces into an array called 'words'
              create empty array called 'pal_cap'
              iterate over 'words'
                check each word to see if its reverse is equal to itself
                if it is, map the word to uppercase
                if not, map the original word
              
              

=end

def change_me(string)
  words = string.split
  pal_cap = words.map do |word|
    word.reverse == word ? word.upcase : word
  end
  pal_cap.join(' ')
end




p change_me("We will meet at noon") == "We will meet at NOON"
p change_me("No palindromes here") == "No palindromes here"
p change_me("") == ""
p change_me("I LOVE my mom and dad equally") == "I LOVE my MOM and DAD equally"