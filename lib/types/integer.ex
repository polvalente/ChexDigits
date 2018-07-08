defmodule ChexDigits.Types.Integer do
  @moduledoc """
  Custom types to represent integers
  """

  use ChexDigits.Types
  alias __MODULE__
  default(0)

  def validate(value) when is_integer(value), do: :ok
  def validate(value), do: {:error, :not_an_integer}

  defmodule Optional do
    @moduledoc "OptionalInteger type"
    default(nil)

    def validate(value) when is_nil(value), do: :ok
    def validate(value), do: Integer.validate(value)
  end

  defmodule NonNegative do
    @moduledoc "NonNegativeInteger type"
    default(0)

    def validate(value) when value < 0, do: {:error, :negative_number}
    def validate(value), do: Integer.validate(value)
  end
end
