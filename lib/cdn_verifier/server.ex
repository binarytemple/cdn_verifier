defmodule CdnVerifier.Server do
  use Raxx.SimpleServer

  @impl Raxx.SimpleServer

  def handle_request(%{method: :GET, path: ["cloudflare"]}, _state) do
    time()
  end

  def handle_request(%{method: :GET, path: ["fastly"]}, _state) do
    time()
  end

  def handle_request(_request, _state) do
    response(:ok)
    |> set_body("Valid paths are /fastly and /cloudflare")
  end

  defp time() do
    response(:ok)
    |> set_body("#{:os.system_time(:millisecond)}")
  end
end
