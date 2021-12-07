def select_fruit(produce)
  produce.reject{|_, type| type != 'Fruit'}
  # produce.each {|item, type| fruit[item] = type if type == 'Fruit'}

end


produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}
p produce