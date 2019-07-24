defmodule Auction do
  alias Auction.{Item, User, Repo, Password}

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

  def get_user_by_username_and_password(username, password) do
    with user when not is_nil(user) <- @repo.get_by(User, %{username: username}),
         true <- Password.verify_with_password(password, user.hashed_password) do
      user
    else
      _ -> Password.dummy_verify
    end
  end

  def get_user(id), do: @repo.get(User, id)

  def new_user, do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> @repo.insert
  end
end
