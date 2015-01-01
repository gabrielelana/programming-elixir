# Write a function that takes a list of dqs and prints each on a separate line,
# centered in a column that has the width of the longest string. Make sure it
# works with UTF characters.
#
# iex> center(["cat", "zebra", "elephant"])
#   cat
#  zebra
# elephant

defmodule Programming.Elixir do
  defmodule Format do
    def center(words) do
      width = words |> Enum.map(&String.length/1) |> Enum.max
      Enum.each words, fn(word) ->
        lw = div(width - String.length(word), 2)
        IO.puts(String.duplicate(" ", lw) <> word)
      end
    end
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case
    import ExUnit.CaptureIO

    test "Format.center/1" do
      assert capture_io(
        fn -> Format.center(["cat", "zebra", "elephant"]) end
      ) === """
        cat
       zebra
      elephant
      """
    end
  end
end
