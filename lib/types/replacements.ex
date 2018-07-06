defmodule ChexDigits.Types.Replacements do
  @moduledoc """
  Exchema type to represent the replacements map
  """
  import Exchema.Notation

  alias Exchema.Types, as: T

  structure(
    before: T.Map,
    after: T.Map
  )
end
