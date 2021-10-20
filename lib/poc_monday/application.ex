defmodule PocMonday.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    cleartext_options = [port: Application.fetch_env!(:poc_monday, :port), cleartext: true]

    secure_options = [
      port: Application.fetch_env!(:poc_monday, :secure_port),
      certfile: certificate_path(),
      keyfile: certificate_key_path()
    ]

    children = [
      {PocMonday.LocalCache, []},
      {PocMonday.API, [cleartext_options]},
      {PocMonday.API, [secure_options]}
    ]

    opts = [strategy: :one_for_one, name: PocMonday.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp certificate_path() do
    Application.app_dir(:poc_monday, "priv/localhost/certificate.pem")
  end

  defp certificate_key_path() do
    Application.app_dir(:poc_monday, "priv/localhost/certificate_key.pem")
  end
end
