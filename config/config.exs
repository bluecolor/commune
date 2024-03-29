# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :commune,
  ecto_repos: [Commune.Repo]

# Configures the endpoint
config :commune, CommuneWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SC3nLEsv7jGokakavU9pkNoYwpNF7HbaBoJQhAYuPKzyf4V+rCupA6ifOTsRX/ET",
  render_errors: [view: CommuneWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Commune.PubSub, adapter: Phoenix.PubSub.PG2]


  # Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# config :scrivener_html,
#   routes_helper: Commune.Router.Helpers,
#   view_style: :bulma


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
