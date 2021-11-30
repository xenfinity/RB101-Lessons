=begin
  Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios:

  what is != and where should you use it?
    not equals should be used in an conditional expression. It returns true if the expressions on either side are not equivalent 

  put ! before something, like !user_name
    turns any object into the opposite of their boolean equivalent
  
  put ! after something, like words.uniq!
    depending on the method (it has to be implemented) this will typically convert the preceding method into one that mutates the caller

  put ? before something
    If there is a space after the ? then it could be the start of a ternary operation in which case Ruby will look for the return value of
    the conditional if the preceding conditional expression is true. There should then be a colon (:) following this value for the return
    value if the conditional is false

  put ? after something
    typically implies that the method is a predicate if it is immediately following the method name. If there is a space before the ? 
    then it could be the start of a ternary operation in which case Ruby will look for the result of a conditional preceding it

  put !! before something, like !!user_name
    turns any object into their boolean equivalent

=end