defmodule CdnVerifier.API do
  def child_spec([server_options]) do
    {:ok, port} = Keyword.fetch(server_options, :port)

    %{
      id: {__MODULE__, port},
      start: {__MODULE__, :start_link, [server_options]},
      type: :supervisor
    }
  end

  def init() do
    %{}
  end

  def start_link(server_options) do
    start_link(init(), server_options)
  end

  def start_link(_config, _server_options) do
    # stack = CdnVerifier.Router.stack(config)

    # Ace.HTTP.Service.start_link(stack, server_options)

    raxx_server = {CdnVerifier.Server, nil}
    http_options = [port: 8080, cleartext: true]

    {:ok, _pid} = Ace.HTTP.Service.start_link(raxx_server, http_options)
  end
end
