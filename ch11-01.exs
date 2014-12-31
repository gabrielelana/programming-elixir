# Write a function that returns true if a single-quoted string contains only
# printable ASCII characters (space through tilde).

defmodule Programming.Elixir do
  defmodule String do
    def printable?(chars) when is_list(chars) do
      Enum.all? chars, fn(char) -> char in ?\s..?~ end
    end
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "String.printable?/1" do
      assert String.printable? 'Gabriele Lana!'
      assert String.printable? '   '
      assert String.printable? [32, 32, 32]
      refute String.printable? [30, 48, 56]
      refute String.printable? [127]
    end
  end
end
