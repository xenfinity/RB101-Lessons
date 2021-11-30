=begin
  Given the hash below
  Turn this into an array containing only two elements: Barney's name and Barney's number

=end

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

barney = flintstones.to_a[flintstones["Barney"]]
p barney

p flintstones.assoc("Barney")
