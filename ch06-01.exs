# Extend the Times module with a triple function that multiplies its parameter
# by three.

defmodule Time do
  def double(n), do: n * 2
  def triple(n), do: n * 3
end

ExUnit.start

defmodule Ch06.Test do
  use ExUnit.Case

  test "Time.triple/1" do
    assert 3 === Time.triple(1)
  end
end
