# In the pmap code, I assigned the value of self to the variable me at the top of
# the method and then used me as the target of the message returned by the
# spawned processes. Why use a separate variable here?

# Change the ^pid in pmap to _pid. This means the receive block will take
# responses in the order the processes send them. Now run the code again. Do you
# see any difference in the output? If you’re like me, you don’t, but the program
# clearly contains a bug. Are you scared by this? Can you find a way to reveal
# the problem (perhaps by passing in a different function, by sleeping, or by
# increasing the number of processes)? Change it back to ^pid and make sure the
# order is now correct.

defmodule Programming.Elixir do
  defmodule Parallel do

    def map(c, f) do
      scatter(c, f, self) |> gather
    end

    defp scatter(c, f, home) do
      Enum.map c, fn e ->
        spawn_link fn ->
          :timer.sleep(:random.uniform(10))
          send home, {self, f.(e)}
        end
      end
    end

    defp gather(pids) do
      Enum.map pids, fn pid ->
        receive do
          {^pid, result} -> result
        end
      end
    end
  end

  IO.inspect Parallel.map(1..100, &(&1 * &1))
end
