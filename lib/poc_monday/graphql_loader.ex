defmodule Graphql.Loader do
  use Nebulex.Caching

  @ttl :timer.hours(1)
  alias PocMonday.LocalCache, as: Cache

  def load_graphql(:create_item), do: real_load_graphql(:create_item)
  def load_graphql(:list_users), do: real_load_graphql(:list_users)

  @decorate cacheable(cache: Cache, opts: [ttl: @ttl])
  defp real_load_graphql(name) when is_atom(name) do
    File.read!(
      :erlang.list_to_binary(:code.priv_dir(:poc_monday)) <>
        "/graphql/" <> Atom.to_string(name) <> ".graphql"
    )
  end
end
