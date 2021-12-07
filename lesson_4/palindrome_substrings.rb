# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.
=begin
  Input - string
  Output is an array of palindromes (as strings)

  - palindromes are case sensitive
  - palindromes can be found within a word
  - return empty array if no plaindromes found
  - return empty array if empty string
  Algorithm
    
=end

def palindrome_substrings(string)
  words = Array.new
  2.upto(string.size-1) { |i| words.concat(string.chars.each_cons(i).to_a) }
  result = words.filter { |word| word.reverse == word }
  result.sort.map(&:join)
end


# Test cases:

p palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
p palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
p palindrome_substrings("palindrome") == []
p palindrome_substrings("") == []