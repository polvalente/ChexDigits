defmodule ChexDigits.Types.List do
  @moduledoc """
  Custom type to represent a list
  """
  use ChexDigits.Types

  default([])

  def validate(value) when is_list(value), do: :ok
  def validate(value), do: {:error, {:not_a_list, value}}
end
