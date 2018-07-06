defmodule ChexDigits.Types.Padding do
  @moduledoc """
  Exchema type to represent padding direction
  """
  import Exchema.Notation

  subtype(Exchema.Types.Atom, fn atom ->
    case atom do
      :left ->
        :ok

      :right ->
        :ok

      _ ->
        {:error, :invalid_padding}
    end
  end)
end
