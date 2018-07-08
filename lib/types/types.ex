defmodule ChexDigits.Types do
  @moduledoc """
  This module contains the macro that hels specify default values for our custom types

  ## Example
    iex(1)> defmodule Example do
    ...> use ChexDigits.Types
    ...> default(:default_value)
    ...> end
    iex(2)> Example.default()
    :default_value
  """
  defmacro __using__(_) do
    quote do
      import ChexDigits.Types, only: [default: 1]
    end
  end

  defmacro default(value) do
    quote do
      def default, do: unquote(value)
    end
  end
end
