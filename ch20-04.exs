# Write a macro called myunless that implements the standard unless function-
# ality. You’re allowed to use the regular if expression in it.


defmodule Programming.Elixir do
  defmodule M do
    defmacro unless(condition, clauses) do
      when_condition_is_falsy = Keyword.get(clauses, :do, nil)
      when_condition_is_truthy = Keyword.get(clauses, :else, nil)

      quote do
        if unquote(condition) do
          unquote(when_condition_is_truthy)
        else
          unquote(when_condition_is_falsy)
        end
      end
    end
  end

  defmodule Test do
    require M

    a = 10
    M.unless a >= 5 do
      IO.puts "less than 5"
    else
      IO.puts "greater than or equal to 5"
    end

    M.unless a < 5, do: IO.puts "OK"
  end
end
