use Mix.Config

if Mix.env() == :dev do
  config :exsync,
    extra_extensions: [".js", ".css"]
end

config :cdn_verifier,
  port: 8080,
  secure_port: 8043
