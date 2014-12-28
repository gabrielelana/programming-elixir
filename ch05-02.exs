# Write a function that takes three arguments. If the first two are zero, return
# “FizzBuzz.” If the first is zero, return “Fizz.” If the second is zero, return
# “Buzz.” Otherwise return the third argument. Do not use any lan- guage features
# that we haven’t yet covered in this book.


ExUnit.start

defmodule Ch05.Test do
  use ExUnit.Case

  test "FizzBuzz" do
    fizzbuzz = fn
      (0, 0, _) -> "FizzBuzz"
      (0, _, _) -> "Fizz"
      (_, 0, _) -> "Buzz"
      (_, _, n) -> n
    end

    assert "FizzBuzz" === fizzbuzz.(0, 0, 3)
    assert "Fizz" === fizzbuzz.(0, 3, 3)
    assert "Buzz" === fizzbuzz.(3, 0, 3)
    assert 3 === fizzbuzz.(3, 3, 3)
  end
end
