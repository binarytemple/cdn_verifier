defmodule CdnVerifier.Router do
  # use Raxx.Server

  use Raxx.Router

  section([{Raxx.Logger, level: :debug}], [
    {%{method: :GET, path: ["ping"]}, Ping}
  ])

  section(&web/1, [
    {%{method: :GET, path: ["cloudflare"]}, CdnVerifier.Actions.Default},
    {%{method: :PUT, path: ["fastly"]}, CdnVerifier.Actions.Default},
    {_, CdnVerifier.Actions.NotFound}
  ])

  def web(state) do
    [
      {Raxx.Logger, level: state.log_level}
    ]
  end
end
