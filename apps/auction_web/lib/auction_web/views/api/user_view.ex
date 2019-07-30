defmodule AuctionWeb.Api.UserView do
  use AuctionWeb, :view

  def render("user.json", %{user: user}) do
    %{
      type: "user",
      username: user.username,
      email: user.email
    }
  end

  def render("item_bid.json", %{bid: bid}) do
    %{
      type: "bid",
      id: bid.id,
      amount: bid.amount,
      user: render_one(bid.user, AuctionWeb.Api.User, "user.json")
    }
  end
end
