use Mix.Config

config :auction, ecto_repos: [Auction.Repo]

config :auction, Auction.Repo,
  database: "auction_test",
  username: "postgres",
  hostname: "localhost",
  port: "5432",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :info
