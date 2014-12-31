# The Pragmatic Bookshelf has offices in Texas (TX) and North Carolina (NC), so
# we have to charge sales tax on orders shipped to these states. The rates can be
# expressed as a keyword list

# tax_rates = [ NC: 0.075, TX: 0.08 ]
# Here’s a list of orders:
# orders = [
#   [id: 123, ship_to: :NC, net_amount: 100.00],
#   [id: 124, ship_to: :OK, net_amount:  35.50],
#   [id: 125, ship_to: :TX, net_amount:  24.00],
#   [id: 126, ship_to: :TX, net_amount:  44.80],
#   [id: 127, ship_to: :NC, net_amount:  25.00],
#   [id: 128, ship_to: :MA, net_amount:  10.00],
#   [id: 129, ship_to: :CA, net_amount: 102.00],
#   [id: 120, ship_to: :NC, net_amount:  50.00]]

# Write a function that takes both lists and returns a copy of the orders, but
# with an extra field, total_amount, which is the net plus sales tax. If a
# shipment is not to NC or TX, there’s no tax applied.

defmodule Programming.Elixir do
  defmodule Order do
    def apply_taxes(orders, tax_rates) do
      for order <- orders do
        net_amount = Keyword.get(order, :net_amount)
        tax_rate = Keyword.get(tax_rates, Keyword.get(order, :ship_to), 0)
        Keyword.put(order, :total_amount, net_amount * (tax_rate + 1))
      end
    end
  end

  ExUnit.start

  defmodule Test do
    use ExUnit.Case

    test "Order.apply_taxes/2" do
      tax_rates = [NC: 0.075, TX: 0.08]
      orders = [
        [id: 123, ship_to: :NC, net_amount: 100.00],
        [id: 124, ship_to: :OK, net_amount:  35.50],
        [id: 125, ship_to: :TX, net_amount:  24.00],
        [id: 126, ship_to: :TX, net_amount:  44.80],
        [id: 127, ship_to: :NC, net_amount:  25.00],
        [id: 128, ship_to: :MA, net_amount:  10.00],
        [id: 129, ship_to: :CA, net_amount: 102.00],
        [id: 120, ship_to: :NC, net_amount:  50.00]]

      assert [
        100.00 * 1.075,
        35.50,
        24.00 * 1.08,
        44.80 * 1.08,
        25.00 * 1.075,
        10.00,
        102.00,
        50.00 * 1.075
        ] ===
        (Order.apply_taxes(orders, tax_rates) |> total_amounts)
    end

    def total_amounts(orders) do
      for order <- orders, do: Keyword.get(order, :total_amount)
    end
  end
end
