defmodule Graphql.Templates do
  @spec create_item(integer(), binary(), atom) :: binary
  def create_item(board_id, item_name, state) do
    column_values = %{"status" => %{label: Atom.to_string(state)}}

    # column_values = Poison.encode!(Poison.encode!(column_values))
    #
    column_values = Poison.encode!(column_values) |> String.replace("\"", "\\\"")

    text = """
    mutation{
      create_item (
        board_id: <%= board_id %>,
        item_name: "<%= item_name %>",
        column_values: "<%= column_values %>"
        ) {
          id,state
        }
      }
    """

    # text = String.replace(text, "\n", "")

    ret =
      EEx.eval_string(
        text,
        board_id: board_id,
        item_name: item_name,
        column_values: column_values
      )

    IO.puts(ret)

    # String.replace(ret, "\"", "\\\"")
    ret
  end
end
