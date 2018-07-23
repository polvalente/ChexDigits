defmodule ChexDigits.Rules.CPF do
  @moduledoc false
  alias ChexDigits.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def execute(r) do
    first_cd =
      r
      |> H.checksum()

    second_cd =
      (r.digits ++ [first_cd])
      |> rule()
      |> H.checksum()

    [first_cd, second_cd]
  end

  def rule(digits) do
    Rule.new(
      digits,
      %{},
      %{},
      11,
      :module_minus,
      to_list(11..2)
    )
  end
end
