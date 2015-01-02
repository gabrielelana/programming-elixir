# Write a function to capitalize the sentences in a string. Each sentence is
# terminated by a period and a space. Right now, the case of the characters in
# the string is random.
#
# iex> capitalize_sentences("oh. a DOG. woof. ")
# "Oh. A dog. Woof. "

defmodule Programming.Elixir do
  defmodule Format do
    def capitalize_sentences(s) do
      s
      |> String.split(~r{\.\s+})
      |> Enum.map(fn
                    <<first::utf8, rest::binary>> ->
                      String.upcase(<<first::utf8>>) <> String.downcase(rest)
                    something_else ->
                      something_else
                  end)
      |> Enum.join(". ")
    end
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "Format.capitalize_sentences/1" do
      assert Format.capitalize_sentences("oh. a DOG. woof. ") == "Oh. A dog. Woof. "
      assert Format.capitalize_sentences("heLLo") == "Hello"
      assert Format.capitalize_sentences("heLLo. WORLD") == "Hello. World"
    end
  end
end
