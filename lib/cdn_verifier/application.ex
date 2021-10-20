defmodule CdnVerifier.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    cleartext_options = [
      port: Application.fetch_env!(:cdn_verifier, :port),
      cleartext: true
    ]

    children = [
      {CdnVerifier.API, [cleartext_options]}
    ]

    opts = [strategy: :one_for_one, name: CdnVerifier.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
