defmodule ChexDigits.Rules.CPF do
  @moduledoc false
  alias ChexDigits.Types.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def execute(r) do
    first_cd =
      r
      |> H.checksum()

    second_cd =
      (r.digits ++ [first_cd])
      |> rule(:second)
      |> H.checksum()

    [first_cd, second_cd]
  end

  def rule(digits) do
    Rule.new(
      digits,
      9,
      :left,
      -11,
      to_list(10..2),
      H.replacements(%{1 => 0, 0 => 0}, %{})
    )
  end

  def rule(digits, :second) do
    Rule.new(
      digits,
      10,
      :left,
      -11,
      to_list(11..2),
      H.replacements(%{1 => 0, 0 => 0}, %{})
    )
  end
end
