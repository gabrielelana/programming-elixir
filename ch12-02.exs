# Many built-in functions have two forms. The xxx form returns the tuple
# {:ok, data} and the xxx! form returns data on success but raises an exception
# otherwise. However, some functions don’t have the xxx! form.

# Write an ok! function that takes an arbitrary parameter. If the parameter is
# the tuple {:ok, data}, return the data. Otherwise, raise an exception
# containing information from the parameter

defmodule Programming.Elixir do
  defmodule Ensure do
    def ok!({:ok, x}), do: x
    def ok!(not_ok), do: raise "Expected {:ok, _} but got #{inspect(not_ok)}"
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "Ensure.ok! when it is" do
      assert Ensure.ok!({:ok, 10}) == 10
    end

    test "Ensure.ok! when is not" do
      assert_raise RuntimeError, "Expected {:ok, _} but got :error", fn ->
        Ensure.ok! :error
      end
    end
  end
end
