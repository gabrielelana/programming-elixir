# An Elixir single-quoted string is actually a list of individual character
# codes. Write a caesar(list, n) function that adds n to each list element,
# wrapping if the addition results in a character greater than z.

defmodule MyList do

  def caesar(l, shift) do
    reduce(l, '', fn(c, encoded) -> encoded ++ [?a + rem(c - ?a + shift, ?z - ?a + 1)] end)
  end

  def reduce([], _), do: raise "Empty list cannot be reduced without an initial value"
  def reduce([h|t], f), do: reduce(t, h, f)

  def reduce([], value, _), do: value
  def reduce([h|t], value, f), do: reduce(t, f.(h, value), f)
end

ExUnit.start

defmodule Ch07.Test do
  use ExUnit.Case

  test "MyList.caesar/2" do
    assert 'elixir' === MyList.caesar('ryvkve', 13)
  end
end
