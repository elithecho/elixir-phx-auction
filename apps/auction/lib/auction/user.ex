defmodule Auction.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Auction.{Bid, Address}

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    has_many :bids, Bid
    has_one :address, Address
    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:username, :email, :password])
    |> validate_required([:username, :email, :hashed_password])
    |> validate_length(:username, min: 4)
    |> unique_constraint(:username)
  end

  def changeset_with_password(user, params \\ %{}) do
    user
    |> cast(params, [:password])
    |> cast_assoc(:address, with: &Address.insert_changeset/2)
    |> validate_required(:password)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, required: true)
    |> hash_password()
    |> changeset(params)
  end

  def changeset_with_address(user, params \\ %{}) do
    user
    |> changeset(params)
  end

  defp hash_password(%Ecto.Changeset{changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:hashed_password, Auction.Password.hash(password))
  end
  defp hash_password(changeset), do: changeset
end
