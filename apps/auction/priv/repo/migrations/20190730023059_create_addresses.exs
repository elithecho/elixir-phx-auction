defmodule Auction.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :line_1, :string
      add :line_2, :string
      add :postcode, :string
      add :state, :string
      add :country, :string
      add :user_id, references(:users)

      timestamps()
    end

    create index :addresses, [:user_id]
  end
end
