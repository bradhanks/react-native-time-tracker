# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :timetrackergql,
  ecto_repos: [Timetrackergql.Repo]

# Configures the endpoint
config :timetrackergql, TimetrackergqlWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uCmq7lXWvaZZUPDpcoH9YXI7bhT34RGV8G9eHteWawWJPJhhU4Cq24LjXmWZjBWi",
  render_errors: [view: TimetrackergqlWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Timetrackergql.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
