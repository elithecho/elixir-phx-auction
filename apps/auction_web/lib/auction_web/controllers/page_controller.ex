defmodule AuctionWeb.PageController do
  use AuctionWeb, :controller

  def index(conn, _params) do
    items = Auction.list_item

    render(conn, "index.html", items: items)
  end
end
