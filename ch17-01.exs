defmodule Programming.Elixir do

  defmodule Stack do
    use Application

    def start(_type, _args) do
      import Supervisor.Spec, warn: false

      children = [
        worker(Stack.Server, [[1, 2, 3]])
      ]

      opts = [
        strategy: :one_for_one
      ]

      Supervisor.start_link(children, opts)
    end
  end

  defmodule Stack.Server do
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

    def all do
      GenServer.call(__MODULE__, :all)
    end

    def handle_call(:pop, _from, [h|t]) do
      {:reply, {:ok, h}, t}
    end
    def handle_call(:all, _from, e) do
      {:reply, {:ok, e}, e}
    end

    def handle_cast({:push, element}, elements) do
      {:noreply, [element|elements]}
    end
  end

  # IO.inspect Stack.start(nil, nil)
  # IO.inspect Process.whereis(Stack.Server)
  ExUnit.start
  # IO.inspect Application.start(Stack)

  # Stack.Server.start([])

  defmodule Stack.Test do
    use ExUnit.Case

    test "expect supervisor restart worker" do
      Stack.start(nil, nil)
      original_pid = Process.whereis(Stack.Server)
      Stack.Server.pop
      Stack.Server.pop
      Stack.Server.pop
      Stack.Server.pop
      respawn_pid = Process.whereis(Stack.Server)
      IO.inspect original_pid
      IO.inspect respawn_pid
    end
  end

  # IO.inspect Process.whereis(Stack.Server)
end
