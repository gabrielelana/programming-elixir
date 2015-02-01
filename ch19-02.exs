defmodule Programming.Elixir do
  defmodule Frequency do
    def start_link do
      Agent.start_link(fn -> HashDict.new end, name: __MODULE__)
    end

    def add_word(word) do
      Agent.update(
        __MODULE__,
        fn dict ->
          Dict.update(dict, word, 1, &(&1+1))
        end
      )
    end

    def count_for(word) do
      Agent.get(__MODULE__, fn dict -> Dict.get(dict, word) end)
    end

    def words do
      Agent.get(__MODULE__, fn dict -> Dict.keys(dict) end)
    end
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "Frequency" do
      Frequency.start_link
      Frequency.add_word("Gabriele")
      assert ["Gabriele"] == Frequency.words
    end
  end
end
