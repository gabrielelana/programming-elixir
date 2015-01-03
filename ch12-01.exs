# Rewrite the FizzBuzz example using case.

defmodule Programming.Elixir do
  defmodule FizzBuzz do
    def upto(n) when n > 1 do
      1..n
      |> Enum.map(&(case &1 do
                      i when rem(i, 15) == 0 -> "FizzBuzz"
                      i when rem(i, 3) == 0 -> "Fizz"
                      i when rem(i, 5) == 0 -> "Buzz"
                      i -> i
                    end))
    end
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "FizzBuzz.upto/1" do
      assert FizzBuzz.upto(20) == [
        1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8,
        "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz",
        16, 17, "Fizz", 19, "Buzz"
      ]
    end
  end
end
