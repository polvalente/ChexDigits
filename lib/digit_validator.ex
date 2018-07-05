defmodule DigitValidator do
  @moduledoc """
  Documentation for DigitValidator.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DigitValidator.hello
      :world

  """
  @spec validate(String.t()) :: List.t()
  def validate(digits) do

  end

  def dot(u, v) when is_list(u) and is_list(v) do
    [u, v]
    |> List.zip()
    |> Enum.reduce(
      0,
      fn({a, b}, acc) ->
        acc + a*b
      end
    )
  end

  def dot(u, v) when is_number(u) and is_list(v),
    do: Enum.map(v, &(&1 * u))

  def dot(u, v) when is_number(v) and is_list(u),
    do: Enum.map(u, &(&1 * v))
end
