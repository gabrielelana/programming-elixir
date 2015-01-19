# You’re going to start creating a server that implements a stack. The call that
# initializes your stack will pass in a list of the initial stack contents.
#
# For now, implement only the pop interface. It’s acceptable for your server to
# crash if someone tries to pop from an empty stack.
#
# For example, if initialized with [5,"cat",9], successive calls to pop will
# return 5, "cat", and 9.


defmodule Programming.Elixir do
  defmodule Stack do
    use GenServer

    def start(elements) when is_list(elements) do
      GenServer.start_link(__MODULE__, elements)
    end

    def pop(stack) do
      GenServer.call(stack, :pop)
    end

    def handle_call(:pop, _from, [h|t]) do
      {:reply, {:ok, h}, t}
    end
    def handle_call(:pop, _from, []) do
      {:reply, {:error, :empty}, []}
    end
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "pop" do
      {:ok, stack} = Stack.start([1,2,3])
      assert Stack.pop(stack) == {:ok, 1}
      assert Stack.pop(stack) == {:ok, 2}
      assert Stack.pop(stack) == {:ok, 3}
      assert Stack.pop(stack) == {:error, :empty}
      assert Stack.pop(stack) == {:error, :empty}
    end
  end
end
