# Using the each method, write some code to output all of the vowels from the strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

vowels = ''
hsh.each_value do |value|
  vowels << value.join.gsub(/[^aeiou]/, '')
end
p vowels

vowels = ''
hsh.each do |_, arr|
  arr.each do |word|
    word.chars.each do |letter|
      vowels << letter if 'aeiou'.include?(letter)
    end
  end
end
p vowels