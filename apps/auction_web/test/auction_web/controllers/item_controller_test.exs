defmodule AuctionWeb.ItemControllerTest do
  use AuctionWeb.ConnCase

  test "GET /", %{conn: conn} do
    {:ok, item} = Auction.insert_item(%{title: "Test Item"})
    conn = get(conn, "/items/#{item.id}")
    assert html_response(conn, 200) =~ "Test Item"
  end

  describe "POST /items" do
    test "with valid params, it creates an item", %{conn: conn} do
      conn = post(conn, "/items", %{"item" => %{title: "One"}})
      assert Enum.count(Auction.list_items) == 1
      assert conn.status == 302
      assert redirected_to(conn) =~ ~r|/items/\d+|
    end

    test "with invalid params, it does not creates an item", %{conn: conn} do
      conn = post(conn, "/items", %{"item" => %{bad_params: "One"}})
      assert Enum.count(Auction.list_items) == 0
    end
  end
end
