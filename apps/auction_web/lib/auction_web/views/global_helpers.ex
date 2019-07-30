defmodule AuctionWeb.GlobalHelpers do
  use Phoenix.HTML

  def integer_to_currency(cents) do
    amount =
      cents
      |> Decimal.div(100)
      |> Decimal.round(2)

    "$#{amount}"
  end

  def formatted_datetime(datetime) do
    datetime
    |> Timex.format("{YYYY}-{0M}-{0D}, {h24}:{m}")
    |> case do
      {:ok, time} -> time
      _ -> ""
    end
  end
end
