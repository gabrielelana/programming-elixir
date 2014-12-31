# Write an anagram?(word1, word2) that returns true if its parameters are anagrams.

defmodule Programming.Elixir do
  defmodule String do
    def anagrams?(w1, w2) when is_binary(w1) and is_binary(w2) do
      anagrams?(Elixir.String.to_char_list(w1), Elixir.String.to_char_list(w2))
    end
    def anagrams?(w1, w2) when is_list(w1) and is_list(w2) do
      Enum.sort(w1) === Enum.sort(w2)
    end
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "String.anagrams?/2" do
      assert String.anagrams?('crap', 'carp')
      assert String.anagrams?('diet', 'tied')
      refute String.anagrams?('aaaa', 'bbbb')

      assert String.anagrams?("crap", "carp")
      assert String.anagrams?("diet", "tied")
      refute String.anagrams?("aaaa", "bbbb")
    end
  end
end
