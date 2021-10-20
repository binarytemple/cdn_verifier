import Config

config :cdn_verifier,
  port: System.fetch_env!("PORT") |> String.to_integer(),
  secure_port: System.fetch_env!("SECURE_PORT") |> String.to_integer()
