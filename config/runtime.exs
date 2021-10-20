import Config

config :poc_monday,
  monday_api_token: System.fetch_env!("MONDAY_API_TOKEN"),
  port: System.fetch_env!("PORT") |> String.to_integer(),
  secure_port: System.fetch_env!("SECURE_PORT") |> String.to_integer()
