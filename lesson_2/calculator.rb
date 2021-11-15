Kernel.puts("Please enter the first operand: ")
num1 = Kernel.gets().chomp()

Kernel.puts("Please enter the second operand: ")
num2 = Kernel.gets().chomp()

Kernel.puts("Please enter the operator (+, = , *, /): ")
op = Kernel.gets().chomp()

case op
when '+' then Kernel.puts("#{num1.to_i() + num2.to_i()}")
when '-' then Kernel.puts("#{num1.to_i() - num2.to_i()}")
when '*' then Kernel.puts("#{num1.to_i() * num2.to_i()}")
when '/' then Kernel.puts("#{num1.to_f() / num2.to_f()}") unless num2.zero?
else Kernel.puts("Invalid operand")
end

