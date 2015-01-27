defmodule Programming.Elixir do

  defmodule M do
    defmacro if(condition, clauses) do
      then_clause = Keyword.get(clauses, :do, nil)
      else_clause = Keyword.get(clauses, :do, nil)

      quote do
        case unquote(condition) do
          value when value in [false, nil] -> unquote(else_clause)
          _                                -> unquote(then_clause)
        end
      end
    end
  end

  defmodule Test do
    require M

    a = 5
    M.if a >= 5 do
      IO.puts "OK"
    else
      IO.puts "KO"
    end
  end
end
