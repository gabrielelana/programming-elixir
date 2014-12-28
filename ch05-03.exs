# The operator rem(a, b) returns the remainder after dividing a by b. Write a
# function that takes a single integer (n) and calls the function in the previ-
# ous exercise, passing it rem(n,3), rem(n,5), and n. Call it seven times with
# the arguments 10, 11, 12, and so on. You should get “Buzz, 11, Fizz, 13, 14,
# FizzBuzz, 16.”

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

    f = fn(n) -> fizzbuzz.(rem(n, 3), rem(n, 5), n) end

    assert "Buzz" === f.(10)
    assert 11 === f.(11)
    assert "Fizz" === f.(12)
    assert 13 === f.(13)
    assert 14 === f.(14)
    assert "FizzBuzz" === f.(15)
    assert 16 === f.(16)
  end
end
