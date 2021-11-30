=begin
  In this hash of people and their age, see if "Spot" is present.
=end
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

p ages.include?("Spot")
p ages.value?(30)
p ages.key?("Herman")