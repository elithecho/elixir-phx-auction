defmodule Auction do
  import Ecto.Query
  alias Auction.{Item, User, Bid, Repo, Password}

  @repo Repo

  def list_items, do: @repo.all(Item)

  def get_item(id), do: @repo.get!(Item, id)
 
  def get_item_by(attrs), do: @repo.get_by(Item, attrs)

  def insert_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> @repo.insert()
  end

  def new_item, do: Item.changeset(%Item{})

  def edit_item(id) do
  end

  def destroy_item(changeset) do
    @repo.delete(changeset)
  end

  @doc """
  Retrieves a User from the database matching the provided password
  # Like this
  not *that*!!
  but **this**!!
  """
  def get_user_by_username_and_password(username, password) do
    with user when not is_nil(user) <- @repo.get_by(User, %{username: username}),
         true <- Password.verify_with_password(password, user.hashed_password) do
      user
    else
      _ -> Password.dummy_verify
    end
  end

  def list_users, do: @repo.all(User)

  def get_user(id), do: @repo.get(User, id)

  def new_user, do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> @repo.insert
  end

  def new_bid, do: Bid.changeset(%Bid{})

  def insert_bid(params) do
    %Bid{}
    |> Bid.changeset(params)
    |> @repo.insert
  end

  def get_item_with_bids(id) do
    bids_query =
      from b in Bid,
        order_by: [desc: :amount]
    # Item
    # |> where([i], i.id == ^id)
    # |> preload([bids: {bids_query, [:user]}])
    # |> Repo.one

    id
    |> get_item
    |> @repo.preload([bids: {bids_query, [:user]}])
  end

  def get_bids_by_user(user) do
    query =
      from b in Bid,
      where: b.user_id == ^user.id,
      order_by: [desc: :inserted_at],
      preload: :item,
      limit: 10

    @repo.all(query)
  end
end
