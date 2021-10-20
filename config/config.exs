use Mix.Config

if Mix.env() == :dev do
  config :exsync,
    extra_extensions: [".js", ".css"]
end

# In the config/config.exs file
config :poc_monday, PocMonday.LocalCache,
  primary: [
    gc_interval: :timer.hours(12),
    max_size: 1_000_000,
    allocated_memory: 2_000_000_000,
    gc_cleanup_min_timeout: :timer.seconds(10),
    gc_cleanup_max_timeout: :timer.minutes(10)
  ]

config :poc_monday,
  monday_api_token: "MONDAY_API_TOKEN",
  port: 8080,
  secure_port: 8043
