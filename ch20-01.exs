defmodule Programming.Elixir do

  defmodule M do
    defmacro macro(p) do
      IO.inspect p
    end
    defmacro macro(a, p) do
      IO.puts "#{inspect a} and #{inspect p}"
    end
  end

  defmodule Test do
    require M

    M.macro :atom
    M.macro 1
    M.macro 1.0
    M.macro [1, 2, 3]
    M.macro "string"
    M.macro {1, 2}
    M.macro do: 1           # [do: 1]
    M.macro do: 1, da: 2    # [do: 1, da: 2]
    M.macro {1, 2, 3, 4, 5} # {:{}, [line: 28], [1, 2, 3, 4, 5]}

    M.macro do              # [do: 1]
      1
    end

    M.macro do              # [do: {:+, [line: 34], [1, 2]}, else: {:+, [line: 36], [3, 4]}]
      1 + 2
    else
      3 + 4
    end

    M.macro(5) do           # 5 and [do: 1]
      1
    end
  end
end
