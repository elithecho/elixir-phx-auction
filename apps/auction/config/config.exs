use Mix.Config

config :auction, ecto_repos: [Auction.Repo]

config :auction, Auction.Repo,
  database: "auction",
  username: "postgres",
  hostname: "localhost",
  port: "5432"
