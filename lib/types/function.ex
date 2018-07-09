defmodule ChexDigits.Types.Function do
  @moduledoc """
  Custom types to represent functions
  """

  use ChexDigits.Types
  alias __MODULE__
  default(& &1)

  def validate(value) when is_function(value), do: :ok
  def validate(value), do: {:error, :not_a_function}
end
