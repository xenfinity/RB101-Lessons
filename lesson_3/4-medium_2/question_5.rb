=begin
Depending on a method to modify its arguments can be tricky:

Whether the below "coincidentally" does what we think we wanted "depends" upon what is going on inside the method.

How can we change this code to make the result easier to predict and easier for the next programmer to maintain?
=end

def rutabaga_str_arr!(a_string_param, an_array_param)
  a_string_param << "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
rutabaga_str_arr!(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"