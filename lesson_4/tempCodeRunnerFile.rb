#remove people with age 100 and greater.

ages = { "Herman" => 32, "Lily" => 30, "Eddie" => 10 }

p ages.reject {|_, age| age > 100}