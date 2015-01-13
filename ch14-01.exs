# Write a program that spawns two processes and then passes each a unique token
# (for example, “fred” and “betty”). Have them send the tokens back.
# – Is the order in which the replies are received deterministic in theory? In practice?
# – If either answer is no, how could you make it so?

defmodule Programming.Elixir do

  defmodule Server do
    def start do
      spawn(__MODULE__, :run, [])
    end
    def run do
      receive do
        {message, from} -> send from, message
      end
    end
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case


    test "non deterministic receive" do
      s1 = Server.start
      s2 = Server.start

      send s1, {"fred", self}
      send s2, {"betty", self}

      receive do
        message -> assert message in ["fred", "betty"]
      end
      receive do
        message -> assert message in ["fred", "betty"]
      end
    end

    test "deterministic selective receive" do
      s1 = Server.start
      s2 = Server.start

      send s1, {"fred", self}
      send s2, {"betty", self}

      receive do
        "fred" = message -> assert message == "fred"
      end
      receive do
        "betty" = message -> assert message == "betty"
      end
    end

    test "deterministic ordered receive" do
      s1 = Server.start
      s2 = Server.start

      send s1, {"fred", self}
      receive do
        message -> assert message == "fred"
      end
      send s2, {"betty", self}
      receive do
        message -> assert message == "betty"
      end
    end
  end

end
