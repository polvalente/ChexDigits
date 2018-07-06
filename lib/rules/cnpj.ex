defmodule ChexDigits.Rules.CNPJ do
  @moduledoc false
  alias ChexDigits.Types.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def check_digits(digits) do
    digits =
      digits
      |> H.to_list()
      |> Enum.take(12)

    first_cd =
      digits
      |> rule()
      |> execute()

    second_cd =
      (digits ++ [first_cd])
      |> rule()
      |> execute()

    [first_cd, second_cd]
  end

  def rule(digits) do
    Rule.new(
      digits,
      13,
      :left,
      11,
      to_list(5..9) ++ to_list(2..9),
      H.replacements(%{10 => 0}, %{})
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

  def execute(rule), do: H.checksum(rule)

  def execute(rule, :cnpj_eighth) do
    rule
    |> H.checksum()
    |> H.to_next_multiple_of(10)
  end
end
