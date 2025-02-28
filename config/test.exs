import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixir_mock_test_demo, ElixirMockTestDemoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "rLwEXtLHE5dc7tlg/MbWrjmRXJN5ieaH/vb55xbqDPGgWIAT/9InYQ7fX50qvpIR",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
