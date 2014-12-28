# Use the &... notation to rewrite the following.
# – Enum.map [1,2,3,4], fn x -> x + 2 end
# – Enum.each [1,2,3,4], fn x -> IO.inspect x end

ExUnit.start

defmodule Ch05.Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "map with & notation" do
    assert [3,4,5,6] === Enum.map([1,2,3,4], &(&1 + 2))
  end

  test "each with & notation" do
    assert capture_io(
      fn -> Enum.each([1,2,3,4], &IO.inspect/1) end
    ) === "1\n2\n3\n4\n"
  end
end
