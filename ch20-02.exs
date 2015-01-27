defmodule Programming.Elixir do
  defmodule M do
    defmacro m1(code) do
      IO.inspect(code)
      code
    end

    defmacro m2(code) do
      IO.inspect(code)
      quote do
        IO.puts("Another Hello World")
      end
    end

    defmacro m3(code) do
      IO.inspect(code)
      quote do
        IO.inspect(unquote(code))
      end
    end

    defmacro m4 do
      quote do
        def foo do
          :foo
        end
      end
    end
  end

  defmodule Test do
    require M

    M.m1 do
      IO.puts("Hello World")
    end
    M.m2 do
      IO.puts("Hello World")
    end
    M.m3 do
      2 + 3
    end
    M.m4
  end

  IO.inspect Test.foo
end
