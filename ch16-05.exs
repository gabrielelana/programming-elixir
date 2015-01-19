
defmodule Programming.Elixir do
  defmodule Stack do
    use GenServer

    def start(elements) when is_list(elements) do
      GenServer.start(__MODULE__, elements, name: __MODULE__)
    end

    def pop do
      GenServer.call(__MODULE__, :pop)
    end

    def push(element) do
      GenServer.cast(__MODULE__, {:push, element})
    end

    def init(elements) do
      Process.flag(:trap_exit, true)
      {:ok, elements}
    end

    def handle_call(:pop, _from, [h|t]) do
      {:reply, {:ok, h}, t}
    end
    def handle_call(:pop, _from, []) do
      # System.halt(1)
      {:stop, :normal, []}
      # {:reply, {:error, :empty}, []}
    end

    def handle_cast({:push, element}, elements) do
      {:noreply, [element|elements]}
    end

    def terminate(reason, state) do
      IO.puts(
        """
        Terminate
          Reason: #{inspect reason}
          State: #{inspect state}
        """
      )
      :ok
    end
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "terminate" do
      Stack.start([])
      Stack.pop
    end
  end
end
