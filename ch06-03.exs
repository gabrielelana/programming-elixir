# Add a quadruple function. (Maybe it could call the double function....)

defmodule Time do
  def double(n), do: n * 2
  def triple(n), do: n * 3
  def quadruple(n), do: double(double(n))
end

ExUnit.start

defmodule Ch06.Test do
  use ExUnit.Case

  test "Time.quadruple/1" do
    assert 4 === Time.quadruple(1)
  end
end
