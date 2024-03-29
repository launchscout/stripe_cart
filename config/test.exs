import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :stripe_cart, StripeCart.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "stripe_cart_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :stripe_cart, StripeCartWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "1/0iThVdx3Q0ZDwJxvxh67k2vvhh2BJr+N+JM6e6bfJbEqaO+2WQDBrJgqfvcvZo",
  server: false

# In test we don't send emails.
config :stripe_cart, StripeCart.Mailer, adapter: Swoosh.Adapters.Test

config :stripe_cart,
  create_checkout_session: &StripeCart.Test.FakeStripe.create_checkout_session/1,
  supervised_processes: [{Cachex, name: :stripe_products}]
# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
