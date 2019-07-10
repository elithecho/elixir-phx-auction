defmodule Auction do
  alias Auction.{Item, Repo}

  @repo Repo

  def list_items do
    @repo.all(Item)
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end
 
  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  # Auction.FakeRepo.all(Auction.Item) |> Enum.at(1) |> Map.take([:title, :description, :ends_at])
  def insert_item(attrs) do
    Auction.Item
    |> struct(attrs)
    |> @repo.insert()
  end
end
