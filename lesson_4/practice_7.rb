#Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

statement_letters = statement.delete(' ').chars.uniq
letters = Hash.new

statement_letters.each { |letter| letters[letter] = statement.count(letter) }
p letters
