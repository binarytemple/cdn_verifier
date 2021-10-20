defmodule Graphql.Client do
  alias Graphql.Templates

  import Logger
  use Nebulex.Caching

  @ttl :timer.hours(1)
  alias PocMonday.LocalCache, as: Cache

  @type status :: :past | :upcoming | :active
  def get_api_token() do
    Application.get_env(:poc_monday, :monday_api_token)
  end

  @spec create_item(integer, binary, status(), Date.t(), Date.t(), binary) :: any()
  def create_item(board_id, item_name, status, start_date, end_date, user_email)
      when (status == :upcoming or
              status == :past or
              status == :active) and
             is_integer(board_id) and is_binary(item_name) do
    columns = %{
      "timeline" => %{from: Date.to_string(start_date), to: Date.to_string(end_date)},
      "status1" => %{label: Atom.to_string(status)},
      "people9" => %{
        "personsAndTeams" => [
          %{
            id: get_user_id_by_email(user_email),
            kind: "person"
          }
        ]
      }
    }

    {:ok, %{body: body}} =
      Neuron.query(
        Graphql.Loader.load_graphql(:create_item),
        %{
          board_id: board_id,
          item_name: item_name,
          column_values: encode_columns(columns)
        },
        url: "https://api.monday.com/v2",
        headers: [authorization: "#{System.fetch_env!("MONDAY_API_TOKEN")}"]
      )

    body
  end

  def encode_columns(%{} = column_values) do
    ret = Poison.encode!(column_values)
    Logger.debug(ret)
    ret
  end

  def get_user_id_by_email(user_email) do
    (get_all_users() |> Enum.filter(&(&1.email == user_email)) |> :erlang.hd()).id
  end

  @decorate cacheable(cache: Cache, opts: [ttl: @ttl])
  def get_all_users() do
    IO.puts("invoking - get_all_users")

    {:ok, %{body: body}} =
      Neuron.query(Graphql.Loader.load_graphql(:list_users), %{},
        url: "https://api.monday.com/v2",
        headers: [authorization: "#{System.fetch_env!("MONDAY_API_TOKEN")}"]
      )

    body["data"]["users"] |> Enum.map(&Morphix.atomorphify!(&1, ["name", "email", "id"]))
  end
end
