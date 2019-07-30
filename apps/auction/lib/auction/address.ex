defmodule Auction.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :line_1, :string
    field :line_2, :string
    field :postcode, :string
    field :state, :string
    field :country, :string
    belongs_to :user, Auction.User
    timestamps()
  end

  @required ~w(line_1 postcode country state)a
  @optional ~w(line_2)a

  def changeset(address, params \\ %{}) do
    address
    |> cast(params, @required, @optional)
    |> validate_required(@required)
  end

  def insert_changeset(address, params \\ %{}) do
    address
    |> cast(params, @required, @optional)
    |> validate_required(@required)
  end
end
