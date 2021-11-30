=begin
Method calls can take expressions as arguments. Suppose we define a method called rps as follows, 
which follows the classic rules of rock-paper-scissors game, but with a slight twist that it 
declares whatever hand was used in the tie as the result of that tie.

What is the result of the following call?
paper
=end

def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")