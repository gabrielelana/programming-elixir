# Write a macro called times_n that takes a single numeric argument. It should
# define a function called times_n in the caller’s module that itself takes a
# single argument, and that multiplies that argument by n. So, calling
# times_n(3) should create a function called times_3, and calling times_3(4)
# should return 12

defmodule Programming.Elixir do

  defmodule Times do
    defmacro times_n(n) when is_integer(n) do
      name = :"times_#{n}"
      quote do
        def unquote(name)(m) do
          unquote(n) * m
        end
      end
    end
  end

  defmodule Shell do
    require Times
    Times.times_n(3)
    Times.times_n(4)
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "times_3" do
      assert 12 == Shell.times_3(4)
    end

    test "times_4" do
      assert 20 == Shell.times_4(5)
    end
  end
end
