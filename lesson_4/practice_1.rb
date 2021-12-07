#Turn this array into a hash where the names are the keys and the values are the positions in the array.

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flint_hash = flintstones.map.with_index {|name, i| [name.to_sym, i]}
p flint_hash.to_h

