# Write a function MyList.span(from, to) that returns a list of the numbers
# from from up to to.

defmodule MyList do
  def span(from, to) when from > to, do: span(to, from)
  def span(from, to) when from < to, do: [from | span(from + 1, to)]
  def span(from, to) when from === to, do: [to]
end

ExUnit.start

defmodule Ch07.Text do
  use ExUnit.Case

  test "MyList.span/2" do
    assert [1,2,3,4,5,6] === MyList.span(1, 6)
  end
end
