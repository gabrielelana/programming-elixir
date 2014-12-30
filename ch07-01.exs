# I defined our sum function to carry a partial total as a second parameter so I
# could illustrate how to use accumulators to build values. The sum function can
# also be written without an accumulator. Can you do it?

defmodule MyList do
  def sum([]), do: 0
  def sum([h|t]), do: h + sum(t)
end

ExUnit.start

defmodule Ch07.Text do
  use ExUnit.Case

  test "Math.sum/1" do
    assert 55 === MyList.sum([1,2,3,4,5,6,7,8,9,10])
  end
end
