# Write a function prefix that takes a string. It should return a new function
# that takes a second string. When that second function is called, it will return
# a string containing the first string, a space, and the second string.

ExUnit.start

defmodule Ch05.Test do
  use ExUnit.Case

  test "prefix" do
    prefix = fn(prefix) ->
      fn(message) ->
        prefix <> " " <> message
      end
    end

    mrs = prefix.("Mrs")

    assert "Mrs Smith" === mrs.("Smith")
  end
end
