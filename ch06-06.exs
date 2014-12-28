# I’m thinking of a number between 1 and 1000.... The most efficient way to find
# the number is to guess halfway between the low and high numbers of the range.
# If our guess is too big, then the answer lies between the bottom of the range
# and one less than our guess. If our guess is too small, then the answer lies
# between one more than our guess and the end of the range. Your API will be
# guess(actual, range), where range is an Elixir range.

# Your output should look similar to this:
# iex> Chop.guess(273, 1..1000)
# Is it 500
# Is it 250
# Is it 375
# Is it 312
# Is it 281
# Is it 265
# Is it 273
# 273

defmodule Chop do
  def guess(actual, from..to) do
    ask(actual, halfway(from, to), from..to)
  end

  def ask(actual, guess, from..to) do
    IO.puts "Is it #{guess}?"
    check(actual, guess, from..to)
  end

  def check(actual, actual, _), do: IO.puts(actual)
  def check(actual, guess, from..to), do: adjust(actual, guess, from..to)

  def adjust(actual, guess, _from..to) when actual > guess do
    ask(actual, halfway(guess, to), guess..to)
  end
  def adjust(actual, guess, from.._to) when actual < guess do
    ask(actual, halfway(from, guess), from..guess)
  end

  defp halfway(min, max), do: min + div(max - min, 2)
end

ExUnit.start

defmodule Ch06.Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "Chop.guess/2" do
    assert capture_io(
      fn -> Chop.guess(273, 1..1000) end
    ) === """
    Is it 500?
    Is it 250?
    Is it 375?
    Is it 312?
    Is it 281?
    Is it 265?
    Is it 273?
    273
    """
  end
end
