#Find the index of the first name that starts with "Be"

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

p flintstones.index {|e| e[0,2] == 'Be'}
