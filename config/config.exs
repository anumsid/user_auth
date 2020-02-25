# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :auth_api,
  ecto_repos: [AuthApi.Repo]

# Configures the endpoint
config :auth_api, AuthApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GtowWG4YzAGcV+B6nym+Vj8ySMgzzZKmv6iOvtbfe9nbX/Vi2Tu5W2BWX1BpHNQP",
  render_errors: [view: AuthApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AuthApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Pow configuration
config :auth_api, :pow,
  user: AuthApi.Users.User,
  repo: AuthApi.Repo,
  web_module: AuthApiWeb,
  extensions: [PowPersistentSession, PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: AuthApiWeb.Pow.Mailer

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
