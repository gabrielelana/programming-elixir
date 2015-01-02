# Chapter 7, Lists and Recursion, on page 61, had an exercise about calculating
# sales tax on page 104. We now have the sales information in a file of
# comma-separated id, ship_to, and amount values. The file looks like this:

#     id,ship_to,net_amount
#     123,:NC,100.00
#     124,:OK,35.50
#     126,:TX,44.80
#     127,:NC,25.00
#     128,:MA,10.00
#     129,:CA,102.00
#     120,:NC,50.00

# Write a function that reads and parses this file and then passes the result to
# the sales_tax function. Remember that the data should be formatted into a
# keyword list, and that the fields need to be the correct types (so the id field
# is an integer, and so on).


defmodule Programming.Elixir do
  defmodule Order do
    def parse(file) do
      File.stream!(file)
      |> Stream.drop(1)
      |> Stream.map(&parse_order/1)
      |> Enum.to_list
    end

    defp parse_order(line) do
      [id, ship_to, net_amount] = line |> String.strip |> String.split(",")
      [ id: String.to_integer(id),
        ship_to: ship_to |> String.lstrip(?:) |> String.to_atom,
        net_amount: String.to_float(net_amount),
      ]
    end
  end


  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "Order.parse/1" do
      assert Order.parse("ch11-06.csv") == [
        [id: 123, ship_to: :NC, net_amount: 100.0],
        [id: 124, ship_to: :OK, net_amount: 35.5],
        [id: 126, ship_to: :TX, net_amount: 44.8],
        [id: 127, ship_to: :NC, net_amount: 25.0],
        [id: 128, ship_to: :MA, net_amount: 10.0],
        [id: 129, ship_to: :CA, net_amount: 102.0],
        [id: 120, ship_to: :NC, net_amount: 50.0]]
    end
  end
end
