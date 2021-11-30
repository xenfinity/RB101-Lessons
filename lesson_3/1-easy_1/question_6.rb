=begin
  Starting with the string:
  famous_words = "seven years ago..."
  show two different ways to put the expected "Four score and " in front of it.
=end

famous_words = "seven years ago..."  
complete = "four score and " << famous_words

p complete

famous_words = "seven years ago..."  
famous_words.gsub!("seven", "four score and seven")

p famous_words

famous_words = "seven years ago..."  
famous_words.prepend("four score and ")

p famous_words