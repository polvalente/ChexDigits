defmodule ChexDigits.Types.Padding do
  @moduledoc """
  Custom type to represent padding direction
  """
  use ChexDigits.Types

  default(:left)

  def validate(value), do: validate(value, [])

  def validate(value, _opts) do
    valid_padding = [:left, :right]

    case Enum.member?(valid_padding, value) do
      true ->
        :ok

      false ->
        {:error, :invalid_padding}
    end
  end
end
