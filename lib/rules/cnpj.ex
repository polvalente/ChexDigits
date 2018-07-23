defmodule ChexDigits.Rules.CNPJ do
  @moduledoc false
  alias ChexDigits.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def execute(r) do
    first_cd = H.checksum(r)

    second_cd =
      (r.digits ++ [first_cd])
      |> rule()
      |> H.checksum()

    [first_cd, second_cd]
  end

  def rule(digits) do
    # Rule.new(
    #   digits,
    #   12,
    #   :left,
    #   -11,
    #   to_list(6..2) ++ to_list(9..2),
    #   H.replacements(%{1 => 0, 0 => 0}, %{})
    # )

    Rule.new(
      digits,
      %{},
      %{11 => 0, 10 => 0},
      11,
      :module_minus,
      to_list(6..2) ++ to_list(9..2),
      :right
    )
  end
end
