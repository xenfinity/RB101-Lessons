=begin
One of the most frequently used real-world string properties is that of "string substitution", 
where we take a hard-coded string and modify it with various parameters from our program.

Given this previously seen family hash, print out the name, age and gender of each family member:

(Name) is a (age)-year-old (male or female).
=end

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}


munsters.each do |name, info|
  puts "#{name} is a #{info['age'].to_s}-year-old #{info['gender']}."
end
