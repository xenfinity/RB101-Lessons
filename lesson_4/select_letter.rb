def select_letter(string, letter)
  letter * string.count(letter)
end

question = 'How many times does a particular character appear in this sentence?'
p select_letter(question, 'a') # => "aaaaaaaa"
p select_letter(question, 't') # => "ttttt"
p select_letter(question, 'z') # => ""

a = ['ant', 'bat', 'caterpillar']
count = a.count do |str|
  str.length < 4
end

p count