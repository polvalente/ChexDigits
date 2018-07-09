defmodule ChexDigits.Rules.CNPJ do
  @moduledoc false
  alias ChexDigits.Types.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def execute(r) do
    first_cd = H.checksum(r)

    second_cd =
      (r.digits ++ [first_cd])
      |> rule(:second)
      |> H.checksum()

    [first_cd, second_cd]
  end

  def rule(digits) do
    Rule.new(
      digits,
      12,
      :left,
      -11,
      to_list(5..2) ++ to_list(9..2),
      H.replacements(%{1 => 0, 0 => 0}, %{})
    )
  end

  def rule(digits, :second) do
    Rule.new(
      digits,
      13,
      :left,
      -11,
      to_list(6..2) ++ to_list(9..2),
      H.replacements(%{1 => 0, 0 => 0}, %{})
    )
  end

  def rule(digits, :cnpj_eighth) do
    Rule.new(
      digits,
      7,
      :left,
      10,
      H.two_one(7),
      H.replacements(%{10 => 0}, %{})
    )
  end

  def execute(rule, :cnpj_eighth) do
    rule
    |> H.checksum()
    |> H.to_next_multiple_of(10)
  end
end
