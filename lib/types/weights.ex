defmodule ChexDigits.Types.Weights do
  @moduledoc """
  Custom type to represent the weights. Weights can be a list or a number.
  """
  use ChexDigits.Types

  default(1)

  def validate(value) when is_number(value), do: :ok
  def validate(value), do: ChexDigits.Types.List.validate(value)
end
