# Give your stack server process a name, and make sure it is accessible by that
# name in iex.


defmodule Programming.Elixir do
  defmodule Stack do
    use GenServer

    def start_link(elements) when is_list(elements) do
      GenServer.start_link(__MODULE__, elements, name: __MODULE__)
    end

    def pop do
      GenServer.call(__MODULE__, :pop)
    end

    def push(element) do
      GenServer.cast(__MODULE__, {:push, element})
    end

    def handle_call(:pop, _from, [h|t]) do
      {:reply, {:ok, h}, t}
    end
    def handle_call(:pop, _from, []) do
      {:reply, {:error, :empty}, []}
    end

    def handle_cast({:push, element}, elements) do
      {:noreply, [element|elements]}
    end
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "pop" do
      Stack.start_link([1,2,3])
      assert Stack.pop == {:ok, 1}
      assert Stack.pop == {:ok, 2}
      assert Stack.pop == {:ok, 3}
      assert Stack.pop == {:error, :empty}
      assert Stack.pop == {:error, :empty}
    end

    test "push" do
      Stack.start_link([])
      assert Stack.pop == {:error, :empty}
      Stack.push(1)
      assert Stack.pop == {:ok, 1}
      Stack.push(2)
      Stack.push(3)
      assert Stack.pop == {:ok, 3}
      assert Stack.pop == {:ok, 2}
    end
  end
end
