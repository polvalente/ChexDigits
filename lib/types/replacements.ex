defmodule ChexDigits.Types.Replacements do
  @moduledoc """
  Exchema type to represent the replacements map
  """

  use ChexDigits.Types

  defstruct(
    before: %{},
    after: %{}
  )

  default(%__MODULE__{before: %{}, after: %{}})

  def validate(value) do
    case Kernel.match?(%__MODULE__{}, value) do
      true ->
        :ok

      false ->
        missing_keys =
          %__MODULE__{}
          |> Map.keys()
          |> :lists.subtract(Map.keys(value))

        {:error, missing_keys: missing_keys}
    end
  end
end
